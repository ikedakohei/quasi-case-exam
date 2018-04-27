require 'test_helper'

class ColumnsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get columns_new_url
    assert_response :success
  end

end
