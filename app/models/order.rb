class Order < ApplicationRecord
  belongs_to :item
  belong_to :user

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
