#Users
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
  specialties.each {|specialty| specialty.subjects.create!(name: name, course_year: course_year )}
end
