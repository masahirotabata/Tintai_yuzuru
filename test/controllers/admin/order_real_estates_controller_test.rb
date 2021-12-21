require 'test_helper'

class Admin::OrderRealEstatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_order_real_estates_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_order_real_estates_show_url
    assert_response :success
  end

end
