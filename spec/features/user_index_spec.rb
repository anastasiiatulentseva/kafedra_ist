require 'rails_helper'

RSpec.feature "Users management" do

  scenario "Admin uses user index", :js do

    guest = create(:guest)
    student = create(:student)
    teacher = create(:teacher)
    banned = create(:banned)
    new_user = create(:user)
    admin = create(:admin)

    user = create(:admin)
    sign_in(user)
    visit users_path
    expect(page).to have_css 'ul.nav-tabs'
    within 'li.active' do
      expect(page).to have_text 'All'
    end
    expect(page).to have_css 'table.table-hover'
    within "tr#user_#{user.id}" do
      expect(page).to have_css 'div.select-role'
    end

    within 'div#user_index' do
      click_link 'New'
      expect(page).to have_css "tr#user_#{new_user.id}"
      expect(page).to_not have_css "tr#user_#{student.id}"

      click_link 'Student'
      expect(page).to have_css "tr#user_#{student.id}"
      expect(page).to_not have_css "tr#user_#{admin.id}"

      click_link 'Teacher'
      expect(page).to have_css "tr#user_#{teacher.id}"
      expect(page).to_not have_css "tr#user_#{student.id}"

      click_link 'Banned'
      expect(page).to have_css "tr#user_#{banned.id}"

      click_link 'Admin'
      expect(page).to have_css "tr#user_#{admin.id}"
      expect(page).to_not have_css "tr#user_#{new_user.id}"

      click_link 'All'
      expect(page).to_not have_css "tr#user_#{guest.id}"
      expect(page).to have_css "tr#user_#{admin.id}"
      expect(page).to have_css "tr#user_#{banned.id}"
      expect(page).to have_css "tr#user_#{teacher.id}"
      expect(page).to have_css "tr#user_#{student.id}"
      expect(page).to have_css "tr#user_#{new_user.id}"
    end
  end

  scenario "Admin assigns roles to new user", :js  do
    new_user = create(:user)

    user = create(:admin)
    sign_in(user)
    visit users_path
    click_link "New"
    within "tr#user_#{new_user.id}"  do
      choose_from_selectize('div.select-role', 'student')
    end
    within 'div#user_index' do
      click_link 'New'
      expect(page).to_not have_css "tr#user_#{new_user.id}"
      click_link 'Student'
      expect(page).to have_css "tr#user_#{new_user.id}"
      within "tr#user_#{new_user.id}"  do
        choose_from_selectize('div.select-role', 'admin')
      end
      expect(page).to have_css "tr#user_#{new_user.id}"
      click_link 'Admin'
      expect(page).to have_css "tr#user_#{new_user.id}"
    end
  end

  scenario "Admin deletes a user", :js  do
    new_user = create(:user)

    user = create(:admin)
    sign_in(user)
    visit users_path

    click_link 'New'
    click_link '×'
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_css "tr#user_#{new_user.id}"
  end

  scenario "Admin bans and unbans a user", :js  do
    new_user = create(:user)

    user = create(:admin)
    sign_in(user)
    visit users_path

    click_link 'New'
    within "tr#user_#{new_user.id}"  do
      click_link 'ban'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_text 'unban'
    end
    click_link 'Banned'
    expect(page).to have_css "tr#user_#{new_user.id}"

    within "tr#user_#{new_user.id}"  do
      click_link 'unban'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_text 'ban'
    end
    click_link 'New'
    expect(page).to have_css "tr#user_#{new_user.id}"

    click_link 'Banned'
    expect(page).to_not have_css "tr#user_#{new_user.id}"
  end
end
