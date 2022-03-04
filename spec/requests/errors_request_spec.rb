require 'rails_helper'

RSpec.describe "Errors", type: :request do
let(:current_user) { create(:user) }
 
  let!(:user) { current_user }
  let(:referer) { 'http://example.com/test' }

  before { sign_in current_user }

  shared_examples "a redirect response" do
    it { expect(response.status).to eq(302) }
  end

  shared_examples "a success response" do
    it { expect(response.status).to eq(200) }
  end

  # Get some page with status not_found

  describe "GET #not_found page" do
    subject { get referer }

    context "user doesn't exist" do
      before(:each) do 
        sign_out user
        subject
      end
      it "redirect to signin page" do
        expect(response.status).to redirect_to new_user_session_path
      end
      it_behaves_like "a redirect response"
    end

    context "user exists" do
      before(:each) { subject }
      it "returns successful response and renders not_found" do
        expect(response.status).to render_template(:not_found)
      end
      it_behaves_like "a success response"
    end
  end

end
