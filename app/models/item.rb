class Item < ApplicationRecord
  has_many :ratings
  has_many :order
  belongs_to :user
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
