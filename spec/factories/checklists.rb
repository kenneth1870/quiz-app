require 'faker'

FactoryBot.define do
  factory :form do
    title { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    public { false }
    
    factory :published_checklist do
      public { true }
    end
    
    factory :checklist_with_questions do
      transient do
        questions_count { 5 }
      end
      after(:create) do |form, evaluator|
        create_list(:question, evaluator.questions_count, form: form)
      end
    end

    factory :published_checklist_with_questions do
      transient do
        questions_count { 5 }
      end
      after(:create) do |form, evaluator|
        create_list(:question, evaluator.questions_count, form: form, public: true)
      end
    end
  end
end
