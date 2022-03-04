# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#get_pages_info' do
    it 'return correct number of pages for first page and 10 forms' do
      expect(helper.get_pages_info(1, 0)).to eq('Showing 1 to 10 of 0 entries')
    end
    it 'return correct number of pages for first page and 20 forms' do
      expect(helper.get_pages_info(1, 2)).to eq('Showing 1 to 10 of 2 entries')
    end
    it 'return correct number of pages for second page and 20 forms' do
      expect(helper.get_pages_info(2, 2)).to eq('Showing 11 to 20 of 2 entries')
    end
  end

  describe '#get_row_number' do
    it 'return correct row number for first audit page' do
      expect(helper.get_row_number(1, 1)).to eq(2)
    end
    it 'return correct row number for second audit page' do
      expect(helper.get_row_number(2, 0)).to eq(11)
    end

    it 'return correct row number for third audit page' do
      expect(helper.get_row_number(3, 5)).to eq(26)
    end
  end
end
