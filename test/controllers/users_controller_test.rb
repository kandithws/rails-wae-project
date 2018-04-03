class UsersControllerTest < ActionDispatch::IntegrationTest
  # All user related will be tested here
  include Devise::Test::IntegrationHelpers

  # Admin stuff
  test "should authenticate as admin to get admin dashboard" do
    sign_in users(:one)
    get rails_admin_path
    assert_redirected_to '/'
  end

  test "admin should get admin dashboard" do
    sign_in users(:three_admin)
    get rails_admin_path
    assert_response :success
  end

  # Registration Controller
  # test "" do
  #   get new_user_registration_path
  # end


  # TODO: Omni Auth Controller
end