class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :specialty
      t.integer :year

      t.timestamps
    end
  end
end
