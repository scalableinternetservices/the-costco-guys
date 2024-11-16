require "test_helper"

class RatingTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: "testuser", password: "password123")
    @item = Item.create(name: "Test Item", description: "A test item")
    @rating = Rating.new(user: @user, item: @item, comment: "Great item!", score: 5)
  end

  test "should be valid with user, item, and comment" do
    assert @rating.valid?
  end

  test "should require a comment" do
    @rating.comment = nil
    assert_not @rating.valid?
    assert_includes @rating.errors[:comment], "can't be blank"
  end

  test "should belong to a user" do
    assert_respond_to @rating, :user
  end

  test "should belong to an item" do
    assert_respond_to @rating, :item
  end
end