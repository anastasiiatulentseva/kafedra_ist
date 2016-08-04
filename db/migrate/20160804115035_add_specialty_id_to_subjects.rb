class AddSpecialtyIdToSubjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :subjects, :specialty, index: true
    add_foreign_key :subjects, :specialties
    remove_column :subjects, :specialty, :string
  end
end
