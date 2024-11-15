require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get register_form" do
    get register_path
    assert_response :success
    assert assigns(:user).is_a?(User)
  end

  test "should handle_register with valid parameters" do
    post register_path, params: { user: { username: "testuser", password: "password", password_confirmation: "password" } }
    assert_redirected_to root_path
    assert User.exists?(username: "testuser")
    assert_equal session[:user]['id'], User.find_by(username: "testuser").id
  end

  test "should handle_register with invalid parameters" do
    post register_path, params: { user: { username: "testuser", password: "password", password_confirmation: "wrongpassword" } }
    assert_template :register_form
    assert_response :unprocessable_entity
    assert assigns(:user).errors.full_messages.include?("Password confirmation doesn't match Password")
  end
end