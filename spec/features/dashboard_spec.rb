require 'rails_helper'

RSpec.feature "Admin's dashboard" do

  scenario "Admin logs in and visits dashboard", :js do
    user = create(:admin)
    sign_in(user)

    visit root_path
    click_link user.name
    click_link 'Dashboard'
    expect(page).to have_css '#content_management'
    expect(page).to have_css '#user_management'

  end

  scenario "Non-admin user cannot visit dashboard", :js do
    user = create(:user)
    sign_in(user)

    visit root_path
    click_link user.name
    expect(page).to have_text 'My profile'
    expect(page).to_not have_text 'Dashboard'

    visit dashboard_path

    expect(page).to have_css 'div.alert-alert'
    expect(page).to_not have_css '#content_management'
    expect(page).to_not have_css '#user_management'

  end

  scenario "Guest user cannot visit dashboard", :js do
    visit dashboard_path
    expect(page).to have_css 'div.alert-alert'
    expect(page).to_not have_css '#content_management'
    expect(page).to_not have_css '#user_management'
  end


end
