require "test_helper"

class ProtectedControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get protected_show_url
    assert_response :success
  end
end
