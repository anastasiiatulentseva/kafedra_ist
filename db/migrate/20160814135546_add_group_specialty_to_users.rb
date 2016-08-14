class AddGroupSpecialtyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :group, :string
    add_column :users, :course_year, :integer
    add_reference :users, :specialty, index: true
    add_foreign_key :users, :specialties
  end
end
