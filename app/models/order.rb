class Order < ApplicationRecord
  has_one :item

  validates :price, presence: true, numericality: { greater_than: 0 }
end
