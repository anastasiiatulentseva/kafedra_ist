class RemoveSpecialtyIdGroupYearFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :group
    remove_column :users, :specialty_id
    remove_column :users, :course_year
  end
end
