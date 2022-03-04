FactoryBot.define do
  factory :audit do
    
    factory :audit_without_answers do
      transient do
        audits_count { 5 }
      end
      after(:create) do |audit, evaluator|
        create_list(:audit, evaluator.audits_count, form: form)
      end
    end
    factory :audit_with_questions do
      transient do
        audits_count { 5 }
      end
      after(:create) do |audit, evaluator|
        create_list(:audit, evaluator.audits_count, form: published_checklist_with_questions, answer: answer)
      end
    end
  end
end
