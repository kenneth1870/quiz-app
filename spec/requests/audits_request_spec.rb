require 'rails_helper'

RSpec.describe "Audits", type: :request do
  
  let!(:user) { create(:user) }
  let!(:form) { create(:form) }
  let!(:audit) { create(:audit, form: form) }
  let(:referer) { 'http://example.com/test' }

  before { sign_in user }

  shared_examples "a redirect response" do
    it { expect(response.status).to eq(302) }
  end

  shared_examples "an unprocessable entity response" do
    it { expect(response.status).to eq(422) }
  end

  shared_examples "a success response" do
    it { expect(response.status).to eq(200) }
  end

  shared_examples "not authorized error" do
    let!(:user) { create(:user) }
    let(:form) {create(:form)}

    before(:each) do
      subject
    end
    it "shows not authorized flashes" do 
      expect(flash[:error]).to include("You are not authorized")
    end

    it { expect(response.location).to eq(referer) }
    it { expect(response.status).to eq(302) }
  end

# Index 

  describe "GET #index" do
    subject { get checklists_path }

    context "user doesn't exist" do
      before(:each) do 
        sign_out user
        subject
      end
      it "redirects to login page" do
        expect(response.status).to redirect_to new_user_session_path
      end
      it_behaves_like "a redirect response"
    end

    context "user exists" do
      before(:each) { subject }
      it "returns successful response and renders index page" do
        expect(response.status).to render_template(:index)
      end
    end
  end

# Pagination Index 

  describe "GET #index pagination test" do
    let!(:audits) { create_list(:audit, 14, form: form) }

    context "first page with 10 audits" do
      subject { get audits_path, params: { page: 1 } }
      it "returns only 10 audits" do
        subject
        expect(assigns(:audits).length).to eq(10)
      end
    end

    context "second page with 5 audits" do
      subject { get audits_path params: { page: 2 } }
      it "returns only 5 audits" do
        subject
        expect(assigns(:audits).length).to eq(5)
      end
    end
    
  end

# New 

  describe "GET #new" do
    subject { get new_checklist_audit_path(form) }
    before(:each) { subject }

    context "successful request" do
     before(:each) { subject }
      it 'has successful status' do
        expect(response.status).to eq(200)
      end
      it "returns successful response and renders new form" do
        expect(response).to render_template(:new)
      end

      it_behaves_like "a success response"

      it "sends a new audit" do
        expect(assigns(:audit)).to be_a(Audit)
      end

    end
  end

  # Show

  describe "GET #show" do
    subject { get checklist_audit_path(form, audit) }
    before(:each) { subject }

    context "successful request" do
      it "returns successful response and renders show page" do
        expect(response.status).to render_template(:show)
      end

      it_behaves_like "a success response"
    end

    context "pass audit with 5 questions" do
      let!(:form) { create(:checklist_with_questions) }
      it "returs audits form with 5 questions" do
        expect(audit.form.questions.length).to eq(5)
      end
      it "returs audits form without answers" do
        expect(audit.answers.length).to eq(0)
      end
    end

    context "pass audit" do
      it "returs valid audit" do
        expect(assigns(:audit)).to be_a(Audit)
      end
    end
  end

# Destroy 

  describe "DELETE #destroy" do
    subject { delete checklist_audit_path(form, audit) }
    
    context 'correct params are passed' do  
      let!(:audit) { create(:audit, form: form) }
      it 'has successful status' do
        subject
        expect(response.status).to eq(302)
      end

      it 'has successful redirect' do
        subject
        expect(response.body).to redirect_to(audits_path)
      end

      it 'delete object from db' do
        expect{subject}.to change(Audit, :count).by(-1)
      end
      it "shows correct audit flash" do 
        subject
        expect(flash[:success]).to include("Audit was successfully destroyed.")
      end
    end
  end

end
