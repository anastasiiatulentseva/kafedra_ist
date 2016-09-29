class TeachersSchedule < ApplicationRecord

  validates_uniqueness_of :week, on: :create

end
