class Item < ApplicationRecord
  has_many :ratings
  has_many :orders
  belongs_to :user
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def average_rating
    ratings.average(:score).to_f.round(2)
  end
end
