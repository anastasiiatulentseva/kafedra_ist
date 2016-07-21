class CreateWorkbooks < ActiveRecord::Migration[5.0]
  def change
    create_table :workbooks do |t|
      t.references :subject, index: true, foreign_key: true
      t.string :name
      t.string :description
      t.string :attachment

      t.timestamps
    end
  end
end
