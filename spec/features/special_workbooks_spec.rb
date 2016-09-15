require 'rails_helper'

RSpec.feature "Special workbooks management" do

  scenario "Admin creates and deletes a special workbook", :js do
    user = create(:admin)
    create(:teacher_profile, user_id: user.id)
    specialty = create(:specialty)
    special_subject = create(:special_subject, specialty_id: specialty.id, teacher_profile_id: user.id)
    simple_subject = create(:subject, specialty_id: specialty.id, teacher_profile_id: user.id)
    sign_in(user)

    visit new_special_workbook_path
    expect(page).to have_css 'div.form-group'
    expect(page).not_to have_link 'Delete'
    fill_in 'workbook[name]', with: " "
    click_button 'Save'

    expect(page).to have_css 'div#error_explanation'

    visit new_special_workbook_path
    fill_in 'workbook[name]', with: "Special workbook1"
    select special_subject.name, :from => "workbook[subject_id]"
    fill_wysiwyg("#workbook_description", "About special workbook1")
    attach_file('workbook[attachment]', Rails.root.join('spec/files/123.zip'))
    click_button 'Save'

    expect(page).to have_css 'div.alert-success'
    expect(page).to have_text 'Special workbook has been created'
    expect(page).to have_text 'Special workbook1'
    expect(page).to have_css "a[href=\"#{Workbook.last.attachment.url}\"]"

    click_link 'Edit special workbook'
    expect(page).to have_css 'div.form-group'
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_css 'div.alert'
    expect(page).to_not have_text 'About special workbook1'
  end
end
