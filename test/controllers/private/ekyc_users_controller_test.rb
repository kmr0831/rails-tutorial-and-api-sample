require 'test_helper'

class Private::EkycUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get private_ekyc_users_update_url
    assert_response :success
  end

end
