require 'test_helper'

class RankingsControllerTest < ActionController::TestCase
  test "should get index" do
    user = users(:default)
    sign_in user

    get :index
    assert_response :success
  end

end
