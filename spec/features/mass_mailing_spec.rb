require 'rails_helper'

RSpec.feature "Admins mass mailing" do

  scenario "Admin sends mass mailout to teacher", :js do
    user = create(:admin)
    sign_in(user)

    visit mailers_mass_mail_path
    expect(page).to have_css 'form#send_mailout'

    select 'teachers', from: 'select_user_roles'
    # attach attachment
    attach_file('form_objects_mass_mailout[attachment]', Rails.root.join('spec/files/123.zip'))

    click_button 'Send this big mailout'
    expect(page).to have_css 'div#error_explanation'

    create(:teacher)

    visit mailers_mass_mail_path
    select 'teachers', from: 'select_user_roles'

    fill_in 'form_objects_mass_mailout[subject]', with: 'mailout subject'
    fill_wysiwyg("#form_objects_mass_mailout_text", "Mass mailout text")

    # attach attachment
    attach_file('form_objects_mass_mailout[attachment]', Rails.root.join('spec/files/123.zip'))

    click_button 'Send this big mailout'
    expect(page).to have_css 'div.alert-success'
  end

  scenario "Admin sends mass mailout to students", :js do
    user = create(:admin)
    sign_in(user)
    specialty_1 = create(:specialty)
    specialty_2 = create(:specialty)
    student_1 = create(:student)
    create(:student_profile,
           user_id: student_1.id,
           specialty_id: specialty_1.id,
           course_year: 1,
           group: '1')
    student_2 = create(:student)
    create(:student_profile,
           user_id: student_2.id,
           specialty_id: specialty_2.id,
           course_year: 2,
           group: '2')
    visit mailers_mass_mail_path

    select 'students', from: 'select_user_roles'
    choose_from_selectize('div#select_specialties', specialty_1.id)
    choose_from_selectize('div#select_specialties', specialty_2.id)
    choose_from_selectize('div#select_course_years', 1)
    choose_from_selectize('div#select_groups', 2)
    click_button 'Send this big mailout'

    expect(page).to have_css 'div#error_explanation'
    expect(page).to have_text 'Users list is empty, select other group of users'

    visit mailers_mass_mail_path

    select 'students', from: 'select_user_roles'

    choose_from_selectize('div#select_specialties', specialty_1.id)
    choose_from_selectize('div#select_course_years', 1)
    choose_from_selectize('div#select_groups', 1)

    fill_in 'form_objects_mass_mailout[subject]', with: 'mailout subject'
    fill_wysiwyg("#form_objects_mass_mailout_text", "Mass mailout text")
    click_button 'Send this big mailout'
    expect(page).to have_css 'div.alert-success'
  end
end
