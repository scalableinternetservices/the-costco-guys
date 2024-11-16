class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :comment, presence: true
  validates :score, presence: true, inclusion: { in: 1..5}
end
