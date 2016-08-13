FactoryGirl.define do
  factory :subject do
    sequence(:name) { |n| "subject_#{n}" }
    sequence(:course_year, (1..6).cycle)
    specialty
  end
end
