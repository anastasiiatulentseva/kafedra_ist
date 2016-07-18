class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :text
      t.string :category
      t.integer :order
      
      t.timestamps
    end
  end
end
