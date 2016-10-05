require 'rails_helper'

RSpec.feature "Teachers schedule management" do

  scenario "Admin creates and edits teachers schedule", :js do
    user = create(:admin)
    teacher_1 = create(:teacher)
    teacher_2 = create(:teacher)
    specialty = create(:specialty)
    subject_1 = create(:subject, specialty_id: specialty.id, teacher_profile_id: teacher_1.teacher_profile.id)
    subject_2 = create(:subject, specialty_id: specialty.id, teacher_profile_id: teacher_2.teacher_profile.id)
    subject_3 = create(:subject, specialty_id: specialty.id, teacher_profile_id: teacher_1.teacher_profile.id)
    sign_in(user)

    visit new_teachers_schedule_path
    expect(page).to have_css '#schedule_table'
    fill_in 'week', with: Date.today
    select subject_1.name, from: "schedule[#{teacher_1.id}][0][1][subject]"
    fill_in "schedule[#{teacher_1.id}][0][1][room]", with: 111
    select subject_2.name, from: "schedule[#{teacher_2.id}][2][2][subject]"
    fill_in "schedule[#{teacher_2.id}][2][2][room]", with: 222

    click_button 'save_on_bottom'
    expect(page).to have_css 'div.alert-success'
    expect(page).to have_css '#schedule_table_show'
    expect(page).to have_text Date.today.at_beginning_of_week.strftime("%d.%m.%Y")
    expect(page).to have_text Date.today.at_end_of_week.strftime("%d.%m.%Y")
    within "table#teacher_#{teacher_1.id}" do
      expect(page).to have_text "#{subject_1.name} 111"
    end
    within "table#teacher_#{teacher_2.id}" do
      expect(page).to have_text "#{subject_2.name} 222"
    end

    expect(page).to have_css 'a#print_pdf'

    find_link('Edit').click
    expect(page).to have_css '#schedule_table'
    select subject_3.name, from: "schedule[#{teacher_1.id}][2][4][subject]"
    fill_in "schedule[#{teacher_1.id}][2][4][room]", with: 333
    click_button 'save_on_bottom'
    expect(page).to have_css 'div.alert-success'
    expect(page).to have_css '#schedule_table_show'
    within "table#teacher_#{teacher_1.id}" do
      expect(page).to have_text "#{subject_3.name} 333"
    end

    click_link user.name
    click_link 'Log out'
    sign_in(teacher_1)
    visit teachers_schedule_path(TeachersSchedule.last.id)
  end

  scenario "non-admin users cannot create teachers schedule", :js do
    user = create(:user)
    teacher = create(:teacher)
    visit new_teachers_schedule_path
    expect(page).to have_css 'div.alert-alert'

    sign_in(user)

    visit new_teachers_schedule_path
    expect(page).to have_css 'div.alert-alert'

    click_link user.name
    click_link 'Log out'
    sign_in(teacher)
    visit new_teachers_schedule_path
    expect(page).to have_css 'div.alert-alert'

  end

end
