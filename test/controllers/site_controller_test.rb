require 'test_helper'

class SiteControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get home" do
    get site_home_url
    assert_response :success
  end

  test "should get main" do
    sign_in users(:one)
    get site_main_url
    assert_response :success
  end

  test "should authenticate get main" do
    get site_main_url
    assert_redirected_to new_user_session_path
  end

  test "should search" do
    sign_in users(:one)
    i = items(:one)
    post site_search_url, params: { search: i.product_name }
    assert_response :success
  end

  test "serach should redirect if no param" do
    sign_in users(:one)
    post site_search_url
    assert_redirected_to root_url
  end

  test "should show category" do
    sign_in users(:one)
    cat = categories(:one)
    get show_url, params: {name: cat.name }
    assert_response :success
  end

  test "should redirect show category" do
    sign_in users(:one)
    # no param given case
    get show_url
    assert_redirected_to root_url
  end

end
