class Specialty < ApplicationRecord

  has_many :subjects, dependent: :destroy
  has_many :users

  validates_presence_of :name

end
