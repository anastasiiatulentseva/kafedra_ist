class Subject < ApplicationRecord
  belongs_to :specialty
  belongs_to :teacher_profile

  has_many :workbooks, dependent: :destroy

  validates_presence_of :name, :specialty_id, :course_year
  validates_inclusion_of :course_year, in: 1..6

  scope :simple, -> { where(special: false) }
  scope :special, -> { where(special: true) }
  scope :for_teacher_or_unassigned, ->(teacher_profile) {
    simple.where(teacher_profile_id: nil).
      or(simple.where(teacher_profile_id: teacher_profile.id))
  }

  scope :for_student, ->(student_profile) {
      where(
      specialty_id: student_profile.specialty_id,
      course_year: student_profile.course_year,
    )
  }

end
