require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:current_user) { create(:user) }
 
  let!(:user) { current_user }
  let!(:form) { create(:form) }
  let(:referer) { 'http://example.com/test' }

  before { sign_in current_user }

# Create 

  describe "POST #create" do
    
    context "correct params are passed" do
      subject { post checklist_questions_path(form, question: question_params) }
      let(:question_params) do
        { title: "How you create this app", description: "What technology do they use"}
      end

      it 'has successful status' do
        subject
        expect(response.status).to eq(302)
      end
      
      it 'sets successful flash' do
        subject
        flash[:success].should =~ /Question was successfully created./
      end
      
      it 'adds new object to db' do
        expect{subject}.to change(Question, :count).by(1)  
      end

      it "renders new template" do
        subject
        expect(response.status).to redirect_to(checklist_path(Form.last))
      end
    end
    
    context "incorrect params in title are passed" do
      subject { post checklist_questions_path(form, question: question_params, format: :js) }
      let(:question_params) do
        { title: "Short title", description: "What technology do they use"}
      end

      it 'has successful status' do
        subject
        expect(response.status).to eq(422)
      end
      
      it 'sets successful flash' do
        subject
        expect(controller).to set_flash[:error].to("Title is too short (minimum is 12 characters)")
      end
      
      it 'not adds new object to db' do
        expect{subject}.to change(Question, :count).by(0)  
      end
    end
    
    context "incorrect params in description are passed" do
      subject { post checklist_questions_path(form, question: question_params, format: :js) }
      let(:question_params) do
        { title: "How you create this app", description: ""}
      end

      it 'has successful status' do
        subject
        expect(response.status).to eq(422)
      end
      
      it 'sets successful flash' do
        subject
        expect(controller).to set_flash[:error].to("Description can't be blank")
      end
      
      it 'not adds new object to db' do
        expect{subject}.to change(Question, :count).by(0)  
      end
    end

  end
end
