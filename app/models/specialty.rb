class Specialty < ApplicationRecord

  has_many :subjects, dependent: :destroy
  has_many :student_profiles
  has_many :workbooks, through: :subjects

  validates_presence_of :name

end
