require 'rails_helper'

RSpec.feature "Users behavior" do

  scenario "User signs up", :js do
    #invalid submission
    visit root_path
    find_link("Log in").click
    find_link("Sign up").click
    expect(page).to have_css 'form#new_user'
    fill_in 'user[name]', with: ''
    fill_in 'user[email]', with: 'a@a.ru'
    fill_in 'user[password]', with: '123'
    fill_in 'user[password_confirmation]', with: '124'
    click_button 'Sign up'
    expect(page).to have_css 'div#error_explanation'

    #valid submission
    visit new_user_registration_path
    fill_in 'user[name]', with: 'User'
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'
    expect(page).to have_css 'div.alert-notice'
  end

  scenario "Student signs up", :js do
    specialty = create(:specialty)

    visit new_user_registration_path
    fill_in 'user[name]', with: 'Student'
    fill_in 'user[email]', with: 'stud@example.com'
    check 'I am student!'
    expect(page).to have_css '#for_student'
    fill_in 'user[student_profile_attributes][course_year]', with: '4'
    select specialty.name, :from => "user[student_profile_attributes][specialty_id]"
    fill_in 'user[student_profile_attributes][group]', with: '42 IST'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'
    expect(page).to have_css 'div.alert-notice'
  end

  scenario "User logs in and out", :js do
    user = create(:user)

    visit root_path
    find_link("Log in").click
    expect(page).to have_css 'form#new_user'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: "foobar"
    click_button 'Log in'
    expect(page).to have_css 'div.alert-notice'

    click_link user.name
    click_link 'Log out'
    expect(page).to have_css 'div.alert-notice'
  end

  scenario "User logs in and edits their profile", :js do
    user = create(:user)
    sign_in(user)

    expect(page).to have_css 'div.alert-notice'
    click_link user.name
    click_link 'My profile'

    expect(page).to have_text user.name
    expect(page).to have_text user.email
    click_link 'Edit profile'
    expect(page).to have_text 'Current picture'
    fill_in 'user[name]', with: 'New user name'
    attach_file('user[picture]', Rails.root.join('spec/files/b.jpg'))
    click_button 'Save'
    expect(page).to have_css 'div.alert-notice'
    expect(page).to have_text 'New user name'
    expect(page).to have_css 'img.img-circle'
  end

end
