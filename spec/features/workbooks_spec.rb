require 'rails_helper'

RSpec.feature "Workbooks management" do

  scenario "Admin creates and deletes a workbook", :js do
    subject = create(:subject)
    user = create(:admin)
    sign_in(user)

    visit new_workbook_path
    expect(page).to have_css 'div.form-group'
    expect(page).not_to have_link 'Delete'
    fill_in 'workbook[name]', with: " "
    click_button 'Save'

    expect(page).to have_css 'div#error_explanation'

    visit new_workbook_path
    fill_in 'workbook[name]', with: "Workbook1"
    select subject.name, :from => "workbook[subject_id]"
    fill_wysiwyg("#workbook_description", "About workbook1")
    attach_file('workbook[attachment]', Rails.root.join('spec/files/123.zip'))
    click_button 'Save'

    expect(page).to have_css 'div.alert-success'
    expect(page).to have_text 'Workbook has been created'
    expect(page).to have_text 'Workbook1'
    expect(page).to have_css "a[href=\"#{Workbook.last.attachment.url}\"]"

    click_link 'Edit workbook'
    expect(page).to have_css 'div.form-group'
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_css 'div.alert'
    expect(page).to_not have_text 'About workbook1'
  end
end
