class Subject < ApplicationRecord

  has_many :workbooks, dependent: :destroy

  validates_presence_of :name, :specialty, :year
  validates_inclusion_of :year, in: 1..6

end
