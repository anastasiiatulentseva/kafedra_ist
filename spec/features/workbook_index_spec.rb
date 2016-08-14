require 'rails_helper'

RSpec.feature "Workbooks index" do

  scenario "Teachers visit workbook index", :js do
    user = create(:teacher)
    another_user = create(:teacher)
    specialty = create(:specialty)
    subject_1 = create(:subject, specialty_id: specialty.id, user_id: user.id)
    subject_2 = create(:subject, specialty_id: specialty.id, user_id: user.id)
    workbook_1 = create(:workbook, subject_id: subject_1.id, user_id: user.id)
    workbook_2 = create(:workbook, subject_id: subject_2.id, user_id: user.id)

    subject_3 = create(:subject, specialty_id: specialty.id, user_id: another_user.id)
    subject_4 = create(:subject, specialty_id: specialty.id, user_id: another_user.id)
    workbook_3 = create(:workbook, subject_id: subject_3.id, user_id: another_user.id)
    workbook_4 = create(:workbook, subject_id: subject_4.id, user_id: another_user.id)

    sign_in(user)

    visit workbooks_path
    expect(page).to have_css '#workbook_index'
    expect(page).to have_text subject_1.name
    expect(page).to have_text subject_2.name
    expect(page).to have_text workbook_1.name
    expect(page).to have_text workbook_2.name

    expect(page).to_not have_text subject_3.name
    expect(page).to_not have_text subject_4.name
    expect(page).to_not have_text workbook_3.name
    expect(page).to_not have_text workbook_4.name

    click_link subject_1.name
    expect(page).to have_text workbook_1.name
    expect(page).to_not have_text workbook_2.name

    click_link subject_2.name
    expect(page).to have_text workbook_2.name
    expect(page).to_not have_text workbook_1.name

    click_link user.name
    click_link 'Log out'

    sign_in(another_user)
    visit workbooks_path
    expect(page).to have_text subject_3.name
    expect(page).to have_text subject_4.name
    expect(page).to have_text workbook_3.name
    expect(page).to have_text workbook_4.name

    expect(page).to_not have_text subject_1.name
    expect(page).to_not have_text subject_2.name
    expect(page).to_not have_text workbook_1.name
    expect(page).to_not have_text workbook_2.name
  end
end
