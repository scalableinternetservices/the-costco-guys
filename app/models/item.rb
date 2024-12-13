class Item < ApplicationRecord
  has_many :ratings
  has_many :orders
  belongs_to :user
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Add cache versioning
  def cache_key_with_version
    "#{super}-#{ratings.maximum(:updated_at)&.utc&.to_s(:usec)}"
  end

  def average_rating
    Rails.cache.fetch([self, "average_rating"]) do
      ratings.average(:score).to_f.round(2)
    end
  end

  def sold_out?
    remaining_quantity <= 0
  end

  def remaining_quantity
    Rails.cache.fetch([self, "remaining_quantity"]) do
      quantity - orders.sum(:quantity)
    end
  end

  def review_summary
    Rails.cache.fetch([self, "review_summary"]) do
      count = ratings.count
      return "No reviews yet" if count == 0
      
      avg = ratings.average(:score)&.round(1)
      "#{count} #{'review'.pluralize(count)} (#{avg} / 5.0)"
    end
  end
end