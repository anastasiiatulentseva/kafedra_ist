class ChangeYearColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :subjects, :year, :course_year
  end
end
