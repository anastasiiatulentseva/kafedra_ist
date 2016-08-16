class TeacherProfile < ApplicationRecord

  belongs_to :user
  has_many :workbooks
  has_many :subjects

  validates_presence_of :user_id

end
