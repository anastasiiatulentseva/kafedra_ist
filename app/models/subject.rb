class Subject < ApplicationRecord

  validates_presence_of :name, :specialty, :year
  validates_inclusion_of :year, in: 1..6

end
