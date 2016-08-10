class Subject < ApplicationRecord
  belongs_to :specialty
  belongs_to :user
  has_many :workbooks, dependent: :destroy

  validates_presence_of :name, :specialty_id, :course_year
  validates_inclusion_of :course_year, in: 1..6

end
