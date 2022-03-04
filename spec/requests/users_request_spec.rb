require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  let!(:user) { create :user }

  context 'when user is logged in' do
    before { sign_in user }

    it { expect(user).to be_present }

    describe '#edit' do
      subject { get edit_user_registration_path }
  
      it { is_expected.to render_template('devise/registrations/edit') }
    end
  end

  # Devise session
  describe '#new' do
    context 'when get signup request' do
      subject { get new_user_registration_path }

      it { is_expected.to render_template('devise/registrations/new') }
    end
  end
end
