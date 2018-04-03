require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:three_admin)
    @report = reports(:one)
    @item = items(:one)
    # @new_report = FactoryGirl.build :report
  end

  test "should create item report" do
    sign_in @user2
    assert_difference('Report.count') do
      post item_reports_url(@item), params: { report: { reason: 'This is bad' } }
    end
    assert_response :redirect
    # assert_redirected_to report_url(Report.last)
  end

  test "should not create double report" do
    sign_in @user
    assert_difference('Report.count', 0) do
      post item_reports_url(@item), params: { report: { reason: 'This is bad' } }
    end
    assert_redirected_to root_url
  end

  test "should destroy report if admin" do
    sign_in @admin
    assert_difference('Report.count', -1) do
      delete report_url(@report)
    end
  end

  test "should not destroy report" do
    sign_in @user
    assert_difference('Report.count', 0) do
      delete report_url(@report)
    end
  end

end
