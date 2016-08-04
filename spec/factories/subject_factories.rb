FactoryGirl.define do
  factory :subject do
    sequence(:name) { |n| "type#{n}" }
    sequence(:course_year, (1..6).cycle)
    specialty
  end
end
