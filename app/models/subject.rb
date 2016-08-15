class Subject < ApplicationRecord
  belongs_to :specialty
  belongs_to :teacher_profile

  has_many :workbooks, dependent: :destroy

  validates_presence_of :name, :specialty_id, :course_year
  validates_inclusion_of :course_year, in: 1..6

  scope :for_user_or_unassigned, ->(user) { where(user_id: nil).or(where(user_id: user.id)) }
end
