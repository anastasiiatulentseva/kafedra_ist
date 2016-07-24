FactoryGirl.define do
  factory :user do
    name "user"
    sequence(:email) { |n| "user#{n}@user.ru" }
    password "foobar"
    password_confirmation "foobar"
    confirmed_at { Time.new }
  end
end
