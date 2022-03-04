require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'current_user' do
    before { get root_path }
    it { expect(controller.current_user).to eq user }
  end

  describe 'sign in and sign out' do
    context 'when user sign in' do
      it do
        get root_path
        expect(response).to render_template(:index)
      end
    end

    context 'when user sign out' do
      it 'don\'t have current user' do
        sign_out user
        expect(response).to be_nil
      end
      it 'not render index page' do 
        sign_out user
        get root_path
        expect(response).not_to render_template(:index)
      end
      it 'redirect to signin page' do 
        sign_out user
        get root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
