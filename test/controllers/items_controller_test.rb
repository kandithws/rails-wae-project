require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    # @item = items(:one)
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:three_admin)
    @item = items(:one)
    @item_new = FactoryGirl.build(:nonbiditem1)
    @category = categories(:one)
    @item_close_deal = items(:one_close_deal)
    @item_bid = items(:one_bid)

    # create like for user 2 for like delete test
    @item.liked_by @user2

  end
  # -- authenticated member test --
  test "should redirect get index" do
    sign_in @user
    get items_url
    assert_redirected_to root_url
  end

  test "should get create item" do
    sign_in @user
    assert_difference('Item.count') do
      post items_url, params: {
          item: {title: @item_new.title,
                 type: @item_new.type,
                 body: @item_new.body,
                 category_id: @category.id,
                 product_name: @item_new.product_name,
                 product_desc: @item_new.product_desc,
                 product_price: @item_new.product_price
          },
          sell_type: @item_new.sell_type_str

      }
    end
    assert Item.last.title == @item_new.title
    assert_redirected_to root_url # This is our site behaviour
  end

  test "should get new item" do
    sign_in @user
    get new_item_url
    assert_response :success
  end

  test "should get show item" do
    sign_in @user
    get item_url(@item)
    assert_select 'td', @item.title # assert that some td has @item.title
    assert_response :success
  end

  test "should get show bid item" do
    sign_in @user
    get item_url(@item_bid)
    assert_select 'td', @item_bid.title
    assert_response :success
  end

  test "should get edit item" do
    sign_in @user
    get edit_item_url(@item)
    assert_response :success
  end

  test "should not get edit closed deal item" do
    sign_in @user
    get edit_item_url(@item_close_deal)
    assert_redirected_to item_url(@item_close_deal)
  end

  test "should not update closed deal item" do
    sign_in @user
    patch item_url(@item_close_deal), params: {
        item: {title: 'BLUEEEEE',
               type: @item_close_deal.type,
               body: @item_close_deal.body,
               category_id: @item_close_deal.category.id,
               product_name: @item_close_deal.product_name,
               product_desc:@item_close_deal.product_desc,
               product_price: @item_close_deal.product_price
        },
        sell_type: @item_close_deal.sell_type_str
    }

    assert_redirected_to item_url(@item_close_deal)
    assert !flash[:error].nil?
  end

  test "should update item" do
    sign_in @user
    patch item_url(@item), params: {
        item: {title: 'BLUEEEEE',
               type: @item.type,
               body: @item.body,
               category_id: @item.category.id,
               product_name: @item.product_name,
               product_desc:@item.product_desc,
               product_price: @item.product_price
        },
        sell_type: @item.sell_type_str
    }

    assert_redirected_to item_url(@item)
    assert !flash[:notice].nil?
  end

  test "should destroy item" do
    sign_in @user
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end
    assert_redirected_to root_url
  end

  test "should like item" do
    sign_in @user
    assert_difference('Like.count') do
      put item_like_url(@item)
    end

    assert_redirected_to item_url(@item)
  end

  test "should unlike item" do
    sign_in @user2
    assert_difference('Like.count', -1) do
      put item_unlike_url(@item)
    end
    assert_redirected_to item_url(@item)
  end

  # TODO -- should not edit bid end item

end
