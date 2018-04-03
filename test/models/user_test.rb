require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @admin = users(:three_admin)
  end


  # https://stackoverflow.com/questions/31171136/rails-validation-test-not-passing
  test "should not be valid without first_name" do
    @user1.first_name = nil
    assert_not @user1.valid?
  end

  test "should not be valid without last_name" do
    @user1.last_name = nil
    assert_not @user1.valid?
  end

  test "should not be valid without email" do
    @user1.email = nil
    assert_not @user1.valid?
  end

  test "should not be valid without phone no" do
    @user1.cell_phone_no = nil
    assert_not @user1.valid?
  end

  test "should not be valid without username" do
    @user1.username = nil
    assert_not @user1.valid?
  end

  test "username should be unique" do
    @user2.username = @user1.username
    assert_not @user2.valid?
  end

  test "email should be unique" do
    @user2.email = @user1.email
    assert_not @user2.valid?
  end

  test "member should be true for normal user and false for admin" do
    assert @user1.member?
    assert_not @admin.member?

  end

end
