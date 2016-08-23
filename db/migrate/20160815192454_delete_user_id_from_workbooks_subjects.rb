class DeleteUserIdFromWorkbooksSubjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :subjects, :user_id
    remove_column :workbooks, :user_id
  end
end
