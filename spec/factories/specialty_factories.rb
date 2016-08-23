FactoryGirl.define do
  factory :specialty do
    sequence(:name) { |n| "specialty_#{n}" }
  end
end
