class AddSpecialtyIdGroupYearToStudentProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :student_profiles, :group, :string
    add_column :student_profiles, :course_year, :integer
    add_reference :student_profiles, :specialty, index: true
    add_foreign_key :student_profiles, :specialties
  end
end
