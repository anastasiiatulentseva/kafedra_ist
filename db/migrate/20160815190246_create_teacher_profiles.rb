class CreateTeacherProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :teacher_profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
