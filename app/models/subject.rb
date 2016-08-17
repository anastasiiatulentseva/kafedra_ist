class Subject < ApplicationRecord
  belongs_to :specialty
  belongs_to :teacher_profile

  has_many :workbooks, dependent: :destroy

  validates_presence_of :name, :specialty_id, :course_year
  validates_inclusion_of :course_year, in: 1..6

  scope :for_teacher_or_unassigned, ->(teacher_profile) { where(teacher_profile_id: nil).or(where(teacher_profile_id: teacher_profile.id)) }
end
