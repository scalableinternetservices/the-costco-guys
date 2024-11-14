require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @sender = User.create(username: "senderuser", password: "password123")
    @recipient = User.create(username: "recipientuser", password: "password123")
    @message = Message.new(from: @sender, to: @recipient, content: "Hello!")
  end

  test "should be valid with from, to, and content" do
    assert @message.valid?
  end

  test "should require content" do
    @message.content = nil
    assert_not @message.valid?
    assert_includes @message.errors[:content], "can't be blank"
  end

  test "should belong to a sender" do
    assert_respond_to @message, :from
    assert_equal @sender, @message.from
  end

  test "should belong to a recipient" do
    assert_respond_to @message, :to
    assert_equal @recipient, @message.to
  end
end