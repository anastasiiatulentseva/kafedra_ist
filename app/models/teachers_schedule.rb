class TeachersSchedule < ApplicationRecord

  validates_uniqueness_of :week, on: :create

  def next
    next_schedule = TeachersSchedule.where('id > ?', id).order(id: :asc).first
    next_schedule || TeachersSchedule.first
  end

  def previous
    previous_schedule = TeachersSchedule.where('id < ?', id).order(id: :asc).first
    previous_schedule || TeachersSchedule.last
  end
end
