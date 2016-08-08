class AddUserIdToWorkbooks < ActiveRecord::Migration[5.0]
  def change
    add_reference :workbooks, :user, index: true
    add_foreign_key :workbooks, :users
  end
end
