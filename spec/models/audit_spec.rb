require 'rails_helper'

RSpec.describe Audit, type: :model do

  let (:form) { build(:form) }
  let (:question) { build(:question, form: form) }
  let (:audit) { build(:audit, form: form) }

  it 'has a valid factory' do
    expect(audit).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:answers).dependent(:destroy) }
    it { is_expected.to belong_to(:form) }
  end
end
