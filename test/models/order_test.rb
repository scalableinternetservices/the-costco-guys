require "test_helper"

class OrderTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: "testuser", password: "password123")
    @item = Item.create(name: "Test Item", description: "A test item")
    @order = Order.new(user: @user, item: @item, quantity: 2)
  end

  test "should be valid with user, item, and quantity" do
    assert @order.valid?
  end

  test "should require a quantity" do
    @order.quantity = nil
    assert_not @order.valid?
    assert_includes @order.errors[:quantity], "can't be blank"
  end

  test "should require quantity to be greater than 0" do
    @order.quantity = 0
    assert_not @order.valid?
    assert_includes @order.errors[:quantity], "must be greater than 0"
  end

  test "should require quantity to be a number" do
    @order.quantity = "two"
    assert_not @order.valid?
    assert_includes @order.errors[:quantity], "is not a number"
  end

  test "should belong to a user" do
    assert_respond_to @order, :user
  end

  test "should belong to an item" do
    assert_respond_to @order, :item
  end
end