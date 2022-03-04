require 'faker'

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    description { Faker::Lorem.sentence(word_count: 5, supplemental: true) }
  end
end
