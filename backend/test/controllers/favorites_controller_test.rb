require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get /v1/" do
    get favorites_/v1/_url
    assert_response :success
  end

end
