require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get results" do
    get home_results_url
    assert_response :success
  end

  test "should get test" do
    get home_test_url
    assert_response :success
  end

end
