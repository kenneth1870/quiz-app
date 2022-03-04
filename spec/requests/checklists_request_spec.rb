require 'rails_helper'

RSpec.describe FormsController, type: :request do
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

  shared_examples "not authorized error" do
    before(:each) do
      request.headers["HTTP_REFERER"] = "http://exapmpe.com/test"
      subject
    end
    it "shows not authorized flashes" do 
      expect(flash[:error]).to include("You are not authorized")
    end

    it { expect(response.location).to eq("http://exapmpe.com/test") }
    it { expect(response.status).to eq(302) }
  end

# Index 

  describe "GET #index" do
    subject { get root_path }

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
    let!(:forms) { create_list(:form, 15) }

    context "first page with 10 forms" do
      subject { get root_path, params: { page: 1 } }
      it "returns only 10 forms" do
        subject
        expect(assigns(:forms).length).to eq(10)
      end
    end

    context "second page with 5 forms" do
      subject { get root_path params: { page: 2 } }
      it "returns only 5 forms" do
        subject
        expect(assigns(:forms).length).to eq(5)
      end
    end
  end

# New

  describe "GET #new" do
    subject { get new_checklist_path }
    before(:each) { subject }

    context "successful request" do
      it "returns successful response and renders new form" do
        expect(response).to render_template(:new)
      end

      it_behaves_like "a success response"

      it "sends a new form" do
        expect(assigns(:form)).to be_a(Form)
        expect(assigns(:form)).to be_a_new(Form)
      end
    end
  end

  # Create
  
  describe "POST #create" do
    let(:checklist_params) do 
       { title: 'Some title with more that 14 characters', description: 'Some description' }
    end
    
    subject { post checklists_path(form: checklist_params) }
    
    context "not authorized user" do
      before(:each) do 
        sign_out current_user
        subject
      end
      
      it "has status unauthorized" do
        expect(response.status).to eq(302)
        expect(response.body).to redirect_to(new_user_session_path)
      end
    end
    
    context 'correct params are passed' do
      it 'has successful status' do
        subject
        expect(response.status).to eq(302)
      end

      it 'sets successful flash' do
        subject
        expect(flash[:success]).to include("Form was successfully created.")
      end

      it 'adds new object to db' do
        expect{subject}.to change(Form, :count).by(1)  
      end
      it "renders new template" do
        subject
        expect(response.status).to redirect_to(checklist_path(Form.last))
      end
    end
    
    context 'incorrect params are passed' do
      let!(:checklist_params) do 
       { title: 'Short title', description: '' }
      end
      it 'has unprocessable status' do
        subject
        expect(response.status).to eq(422)
      end

      it 'sets correct flash' do
        subject
        expect(flash[:error]).to include("Description can't be blank")
      end

      it 'not adds new object to db' do
        expect{subject}.to change(Form, :count).by(0)  
      end
    end
  end

# Show

  describe "GET #show" do
    subject { get checklist_path(form) }
    before(:each) { subject }

    context "successful request" do
      let(:form) { create(:form) }
      it "returns successful response  and renders show page" do
        expect(response.status).to render_template(:show)
      end

      it_behaves_like "a success response"
    end

    context "pass form with 6 questions" do
      let!(:form) { create(:checklist_with_questions) }
      it "returs form with 6 questions" do
        expect(assigns(:form).questions.length).to eq(6)
      end
    end

    context "pass form" do
      let(:form) { create(:form) }
      it "returs valid form" do
        expect(assigns(:form)).to be_a(Form)
        expect(assigns(:form)).to eq(form)
      end
    end
  end

# Destroy

  describe "DELETE #destroy" do
    subject { delete checklist_path(form) }

    let!(:form) { create(:form) }
    
    context 'correct params are passed' do  
      it 'has successful status' do
        subject
        expect(response.status).to eq(302)
      end

      it 'has successful redirect' do
        subject
        expect(response.body).to redirect_to(checklists_path)
      end

      it 'sets successful flash' do
        subject
        flash[:success].should =~ /Form was successfully destroyed./
      end

      it 'delete object from db' do
        expect{subject}.to change(Form, :count).by(-1)
      end
    end
  end

end
