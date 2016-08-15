class TeacherProfile < ApplicationRecord

  belongs_to :user
  has_many :workbooks
  has_many :subjects
end
