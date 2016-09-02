require 'rails_helper'

RSpec.feature "Users mailing" do

  scenario "User sends feedback as guest and signed in user", :js do
    user = create(:user)

    visit root_path

    expect(page).to have_css 'form#feedback'
    fill_in 'form_objects_user_feedback[text]', with: "some text"
    fill_in 'form_objects_user_feedback[user_email]', with: "user@user.ru"
    click_button 'send'
    expect(page).to have_css "div.alert-success"

    sign_in(user)
    visit root_path
    expect(page).to have_css 'form#feedback'
    click_button 'send'
    expect(page).to have_css 'div#feedback_errors'
    expect(page).to have_text "Text can't be blank"
    fill_in 'form_objects_user_feedback[text]', with: "some text"
    expect(page).to have_css("input[value='#{user.email}']")
    click_button 'send'

    expect(page).to have_css "div.alert-success"
  end

  scenario "User send email to another user via profile contact form", :js do
    user = create(:user, email: "sender@user.ru")
    another_user = create(:user, email: "recipient@user.ru")

    sign_in(user)

    visit user_path(another_user.id)
    find_link("Contact user").click
    expect(page).to have_text "Contact #{another_user.name}"
    expect(page).to have_css 'form#contact_user'

    fill_in 'subject', with: 'subject'
    fill_in 'text', with: 'some letter text'
    expect(page).to have_css("input[value='#{user.email}']")
    click_button 'send'

    expect(page).to have_css "div.alert-success"
    expect(page).to have_text "Contact user"
  end
end
