class AddSpecialToSubjects < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :special, :boolean, default: false
  end
end
