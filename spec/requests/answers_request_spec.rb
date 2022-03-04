require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let(:current_user) { create(:user) }
 
  let!(:user) { current_user }
  let!(:form) { create(:checklist_with_questions) }
  let!(:audit) { create(:audit, form: form) }
  let(:referer) { 'http://example.com/test' }

  before { sign_in current_user }

  shared_examples "a redirect response" do
    it { expect(response.status).to eq(302) }
  end
  
  shared_examples "a success response" do
    it { expect(response.status).to eq(200) }
  end
  
  describe "POST #create" do
    subject { post checklist_audit_answers_path(form, audit, answer: answer_params, format: :js) }
    
    context "correct params are passed" do
      let(:answer_params) do
        { answer: 'Yes', comment: 'Some comment here for test', 
          question_id: form.questions.first.id }
        end 

      it 'has successful status' do
        subject
        expect(response.status).to eq(200)
      end
      
      it 'sets successful flash' do
        subject
        flash[:success].should =~ /Your answer has been saved./
      end
      
      it 'adds new object to db' do
        expect{subject}.to change(Answer, :count).by(1)  
      end
    end
    
    context "correct params are passed" do
      let(:answer_params) do
        { answer: 'Yes', comment: '', 
          question_id: form.questions.first.id }
        end 

      it 'has successful status' do
        subject
        expect(response.status).to eq(422)
      end
      
      it 'sets error flash' do
        subject
         expect(flash[:error]).to include("Comment is too short (minimum is 12 characters)")
      end
      
      it 'adds new object to db' do
        expect{subject}.to change(Answer, :count).by(0)  
      end
    end
  end

end
