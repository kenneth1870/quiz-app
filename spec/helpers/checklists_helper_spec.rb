require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ChecklistsHelper. For example:
#
# describe ChecklistsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ChecklistsHelper, type: :helper do
  
  let (:unpublished_checklist) { build(:form) }
  let (:published_checklist) { build(:published_checklist) }

  describe "#get_public_name" do
    it "return correct name for unpublished form"  do
      expect(helper.get_public_name(unpublished_checklist.public)).to eq("Unpublished")
    end
    it "return correct name for published form"  do
      expect(helper.get_public_name(published_checklist.public)).to eq("Published")
    end
  end
  
  describe "#get_checkbox_style" do
    it "return correct style for unpublished form"  do
      expect(helper.get_checkbox_style(unpublished_checklist.public)).to eq("")
    end
    it "return correct style for published form"  do
      expect(helper.get_checkbox_style(published_checklist.public)).to eq("checked=\"checked\"")
    end
  end
  
end
