#Users
password = "123456"
student = User.create!(
            name: "Student",
            email: "student@student.ru",
            password: password,
            password_confirmation: password,
            confirmed_at: Time.new,
            roles_mask: 1
          )
student.create_student_profile(group: "42group", course_year: 4)
User.create!(
  name: 'Teacher',
  email: 'teacher@teacher.ru',
  password: password,
  password_confirmation: password,
  confirmed_at: Time.new
)
User.create!(
  name: 'admin',
  email: 'admin@admin.ru',
  password: password,
  password_confirmation: password,
  confirmed_at: Time.new,
  roles_mask: 7
)
10.times do |n|
  name = Faker::Name.name_with_middle
  email = Faker::Internet.email
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    confirmed_at: Time.new
  )
end

#Specialties
7.times do |n|
  Specialty.create!(name: Faker::Educator.campus)
end

#subjects
specialties = Specialty.all
8.times do |n|
  name = Faker::Educator.course
  course_year = Faker::Number.between(1, 6)
  specialties.each do |specialty|
    specialty.subjects.create!(name: name, course_year: course_year)
  end
end
