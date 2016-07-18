class Article < ApplicationRecord
  
  validates_presence_of :name
  validates :order, numericality: { only_integer: true }, allow_nil: true
  
end
