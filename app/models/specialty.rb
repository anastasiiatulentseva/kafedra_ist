class Specialty < ApplicationRecord

  has_many :subjects, dependent: :destroy
  has_many :student_profiles
  has_many :users, through: :student_profiles
  has_many :workbooks, through: :subjects

  validates_presence_of :name

  scope :with_ids, ->(ids) { where(id: ids) }
end
