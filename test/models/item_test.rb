require "test_helper"

class ItemTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: "testuser", password: "password123")
    @item = Item.new(user: @user, name: "Test Item", description: "A sample item description", price: 10.0)
  end

  test "should be valid with user, name, description, and price" do
    assert @item.valid?
  end

  test "should require a name" do
    @item.name = nil
    assert_not @item.valid?
    assert_includes @item.errors[:name], "can't be blank"
  end

  test "should require a description" do
    @item.description = nil
    assert_not @item.valid?
    assert_includes @item.errors[:description], "can't be blank"
  end

  test "should require a price" do
    @item.price = nil
    assert_not @item.valid?
    assert_includes @item.errors[:price], "can't be blank"
  end

  test "should require price to be greater than 0" do
    @item.price = 0
    assert_not @item.valid?
    assert_includes @item.errors[:price], "must be greater than 0"
  end

  test "should require price to be a number" do
    @item.price = "ten dollars"
    assert_not @item.valid?
    assert_includes @item.errors[:price], "is not a number"
  end

  test "should belong to a user" do
    assert_respond_to @item, :user
  end

  test "should have many ratings" do
    assert_respond_to @item, :ratings
  end

  test "should have many orders" do
    assert_respond_to @item, :orders
  end
end
