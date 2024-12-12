class AddPerformanceIndexes < ActiveRecord::Migration[7.1]
  def change
    # Items
    add_index :items, :created_at

    # Ratings
    add_index :ratings, [:item_id, :created_at]

    # Messages
    add_index :messages, [:from_id, :to_id, :created_at]
    add_index :messages, [:to_id, :from_id, :created_at]

    # Orders
    add_index :orders, [:user_id, :created_at]
    add_index :orders, [:item_id, :created_at]

    # Users
    add_index :users, :username, unique: true
  end
end