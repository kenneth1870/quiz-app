require 'faker'

FactoryBot.define do
  factory :answer do
    answer { ['Yes', 'No', 'N/A'].sample }
    comment { Faker::Lorem.sentence(word_count: 5, supplemental: true) }
  end
end
