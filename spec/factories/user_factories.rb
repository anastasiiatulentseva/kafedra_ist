FactoryGirl.define do
  factory :user do
    name "user"
    sequence(:email) { |n| "user#{n}@user.ru" }
    password "foobar"
    password_confirmation "foobar"
    confirmed_at { Time.new }

    factory :admin do
      sequence(:email) { |n| "admin#{n}@admin.ru" }
      roles :admin
    end

    factory :student do
      sequence(:email) { |n| "student#{n}@student.ru" }
      roles :student
    end

    factory :teacher do
      sequence(:email) { |n| "teacher#{n}@teacher.ru" }
      roles :teacher
      after(:create) do |teacher|
        teacher.teacher_profile ||= create(:teacher_profile, user_id: teacher.id)
      end
    end

    factory :banned do
      sequence(:email) { |n| "banned#{n}@banned.ru" }
      banned_at {Time.new}
    end

    factory :guest do
      sequence(:email) { |n| "guest#{n}@guest.ru" }
      guest true
    end
  end
end
