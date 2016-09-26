class CreateTeachersSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers_schedules do |t|
      t.date :week
      t.json :schedule

      t.timestamps
    end
  end
end
