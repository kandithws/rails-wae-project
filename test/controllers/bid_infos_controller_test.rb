require 'test_helper'

class BidInfosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @bid_info = bid_infos(:one_bid)
    @item = items(:one_bid)
    @user = users(:one)
  end

  # Basic Create test
  test "should create bid_info" do
    sign_in @user
    assert_difference('BidInfo.count') do
      post item_bid_infos_url(@item), params: { bid_info: { bid_price: '20.000' } }
    end
    assert_redirected_to item_url(@item)
  end

  test "should update bid_info" do
    sign_in @user
    patch bid_info_url(@bid_info), params: { bid_info: { bid_price: '1000.000' }  }
    assert_redirected_to item_url(@item)
  end

  test "should destroy bid_info" do
    sign_in @user
    assert_difference('BidInfo.count', -1) do
      delete bid_info_url(@bid_info)
    end
    assert_redirected_to item_url(@item)
  end


end
