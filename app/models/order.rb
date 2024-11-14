class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
