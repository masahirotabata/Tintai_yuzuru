require 'test_helper'

class Public::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_addresses_index_url
    assert_response :success
  end

  test "should get new" do
    get public_addresses_new_url
    assert_response :success
  end

end
