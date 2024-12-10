# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Create a user to associate with the items
user = User.create(username: "test_seller", password: "test_seller")

# Generate 1000 items
1000.times do
  Item.create(
    user: user,
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence(word_count: 10),
    price: Faker::Commerce.price(range: 1.0..100.0),
    quantity: rand(1..100) # Random quantity between 1 and 100
  )
end