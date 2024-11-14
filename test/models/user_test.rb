require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "testuser", password: "password123")
  end

  test "should be valid with a username and password" do
    assert @user.valid?
  end

  test "should require a username" do
    @user.username = nil
    assert_not @user.valid?
    assert_includes @user.errors[:username], "can't be blank"
  end

  test "should require a password on creation" do
    @user.password = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password], "can't be blank"
  end

  test "should not require a password when updating without password change" do
    @user.save
    @user.username = "updatedusername"
    assert @user.valid?
  end

  test "should require a password if password_digest changes" do
    @user.save
    @user.password_digest = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password], "can't be blank"
  end

  test "should have many orders" do
    assert_respond_to @user, :orders
  end

  test "should have many ratings" do
    assert_respond_to @user, :ratings
  end

  test "should have many items" do
    assert_respond_to @user, :items
  end

  test "should have many messages" do
    assert_respond_to @user, :messages
  end

  test "authenticates with correct password" do
    @user.save
    assert @user.authenticate("password123")
  end

  test "does not authenticate with incorrect password" do
    @user.save
    assert_not @user.authenticate("wrongpassword")
  end
end