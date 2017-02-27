require 'test_helper'

class OrphansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orphans_index_url
    assert_response :success
  end

  test "should get assign" do
    get orphans_assign_url
    assert_response :success
  end

end
