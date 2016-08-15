class StudentProfile < ApplicationRecord

  belongs_to :user
  belongs_to :specialty

end
