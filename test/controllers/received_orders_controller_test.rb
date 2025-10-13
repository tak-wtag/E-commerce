require "test_helper"

class ReceivedOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get received_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get received_orders_show_url
    assert_response :success
  end
end
