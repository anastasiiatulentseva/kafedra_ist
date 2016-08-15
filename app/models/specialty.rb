class Specialty < ApplicationRecord

  has_many :subjects, dependent: :destroy
  has_many :users
  has_many :workbooks, through: :subjects

  validates_presence_of :name

end
