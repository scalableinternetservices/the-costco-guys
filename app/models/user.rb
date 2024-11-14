class User < ApplicationRecord
  has_secure_password

  has_many :orders
  has_many :ratings
  has_many :items
  has_many :messages

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, if: :password_digest_changed?
end
