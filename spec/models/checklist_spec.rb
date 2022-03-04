require 'rails_helper'

RSpec.describe Form, type: :model do
  
  let (:form) { build(:form) }

  it 'has a valid factory' do
    expect(build(:form)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:questions).dependent(:destroy) }
    it { is_expected.to have_many(:audits).dependent(:destroy) }
  end

  describe 'validations' do
    context 'name' do
      it { is_expected.to have_db_column(:title).of_type(:string) }
      it { is_expected.to have_db_column(:description).of_type(:text) }
      it { is_expected.to have_db_column(:public).of_type(:boolean) }
      it { is_expected.to validate_length_of(:title).is_at_most(40) }
    end
  end

  describe "#count_questions" do
    let(:checklist_without_questions) { create(:form) }
    let(:checklist_with_questions) { create(:checklist_with_questions) }

    context 'with no question' do
      subject {checklist_without_questions.count_questions }

      it { is_expected.to eq(0) }
    end
    context 'with some questions' do
      subject {checklist_with_questions.count_questions }

      it { is_expected.to eq(checklist_with_questions.questions.count) }
    end
  end

  describe "#filter published" do
  subject { Form.published }
  
    context "not published" do
      let!(:checklist_not_published) { create(:form) }
      it "returns 0 form" do
        expect(subject.count).to eq(0)
      end
    end
    
    context "published" do
      let!(:published_checklist) { create(:published_checklist) }
      it "returns 1 form" do
        expect(subject.count).to eq(1)
      end
    end
  end

end
