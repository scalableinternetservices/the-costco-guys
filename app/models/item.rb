class Item < ApplicationRecord
  has_many :ratings
  has_many :orders
  belongs_to :user
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def sold_out?
    remaining_quantity <= 0
  end

  def remaining_quantity
    quantity - orders.sum(:quantity)
  end

  def review_summary
    count = ratings.count
    return "No reviews yet" if count == 0
    
    avg = ratings.average(:score)&.round(1)
    "#{count} #{'review'.pluralize(count)} (#{avg} / 5.0)"
  end
end