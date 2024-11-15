require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get login form when not logged in" do
    get login_path
    assert_response :success
    assert_template :login_form
  end
end
