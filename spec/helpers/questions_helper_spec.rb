require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the QuestionsHelper. For example:
#
# describe QuestionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe QuestionsHelper, type: :helper do
  #   def get_questions_title(sum_questions)
  #   sum_questions <= 1 ? "Question:" : sum_questions.to_s + " Questions:" 
  # end
  describe "#get_checkbox_style" do
    it "return correct title name for 1 Question"  do
      expect(helper.get_questions_title(1)).to eq("Question:")
    end
    it "return correct title name for many Questions"  do
      expect(helper.get_questions_title(5)).to eq("5 Questions:")
    end
  end

end
