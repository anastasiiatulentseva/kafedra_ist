require 'rails_helper'

RSpec.feature "Subject management" do

  scenario "Teacher set their subjects", :js do
    user = create(:teacher)
    specialty = create(:specialty)
    subject = create(:subject, specialty_id: specialty.id)

    sign_in(user)

    visit user_path(user.id)
    click_link "Set subjects"

    expect(page).to have_css '#select_subjects_form'
    choose_from_selectize('#select_subjects_dropdown', subject.id)
    click_button 'Submit'

    visit new_workbook_path
    fill_in 'workbook[name]', with: "Workbook1"
    select subject.name, :from => "workbook[subject_id]"
    fill_wysiwyg("#workbook_description", "About workbook1")
    attach_file('workbook[attachment]', Rails.root.join('spec/files/123.zip'))
    click_button 'Save'
  end

  scenario "Teachers cannot set same subjects", :js do
    user = create(:teacher, name: "One")
    another_user = create(:teacher, name: "Two")
    specialty = create(:specialty)
    subject_1 = create(:subject, specialty_id: specialty.id)
    subject_2 = create(:subject, specialty_id: specialty.id)

    sign_in(user)

    visit set_subjects_user_path(user.id)
    find('.selectize-input').click
    expect(page).to have_css (".selectize-dropdown-content .option[data-value='#{subject_1.id}']")
    find(".selectize-dropdown-content .option[data-value='#{subject_2.id}']").click
    click_button 'Submit'
    click_link user.name
    click_link 'Log out'

    sign_in(another_user)
    visit set_subjects_user_path(another_user.id)
    find('.selectize-input').click
    expect(page).to_not have_css (".selectize-dropdown-content .option[data-value='#{subject_2.id}']")
    find(".selectize-dropdown-content .option[data-value='#{subject_1.id}']").click

    click_button 'Submit'
  end
end
