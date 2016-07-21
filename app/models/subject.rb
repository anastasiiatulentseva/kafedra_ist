class Subject < ApplicationRecord

  has_many :workbooks, dependent: :destroy

  validates_presence_of :name, :specialty, :course_year
  validates_inclusion_of :course_year, in: 1..6

end
