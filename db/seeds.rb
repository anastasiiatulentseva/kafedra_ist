30.times do |n|
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
