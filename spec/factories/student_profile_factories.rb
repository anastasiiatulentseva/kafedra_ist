FactoryGirl.define do
  factory :student_profile do
    user
    sequence(:course_year, (1..6).cycle)
    specialty
    sequence(:group) { |n| "GR #{n}" }
  end
end
