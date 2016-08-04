class Specialty < ApplicationRecord

  has_many :subjects, dependent: :destroy

  validates_presence_of :name

end
