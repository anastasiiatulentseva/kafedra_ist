FactoryGirl.define do
  factory :subject do
    sequence(:name) { |n| "type#{n}" }
    sequence(:year, (1..6).cycle)
    sequence(:specialty) { |n| "Specialty#{n}" }
  end
end
