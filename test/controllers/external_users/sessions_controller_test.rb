require "test_helper"

class ExternalUsers::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get external_users_sessions_create_url
    assert_response :success
  end
end
