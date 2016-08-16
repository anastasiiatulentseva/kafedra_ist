class StudentProfile < ApplicationRecord

  belongs_to :user
  belongs_to :specialty

  validates_presence_of :user_id, :specialty_id
  validates_inclusion_of :course_year, in: 1..6

end
