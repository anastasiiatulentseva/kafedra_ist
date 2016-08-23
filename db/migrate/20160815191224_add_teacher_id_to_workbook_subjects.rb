class AddTeacherIdToWorkbookSubjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :subjects, :teacher_profile, index: true
    add_foreign_key :subjects, :teacher_profiles

    add_reference :workbooks, :teacher_profile, index: true
    add_foreign_key :workbooks, :teacher_profiles
  end
end
