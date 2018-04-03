require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    @item = items(:one)
    @comment = comments(:one)
  end

  test "should create comment" do
    sign_in @user
    assert_difference('Comment.count') do
      post item_comments_path(@item), params: { comment: { body: 'HEllo world!'} }
    end
    assert_redirected_to item_url(@item)
  end


  test "should update comment" do
    sign_in @user
    patch comment_url(@comment), params: { comment: { body: 'editing' } }
    assert_redirected_to item_url(@item)
  end

  test "should destroy comment" do
    sign_in @user
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to item_url(@item)
  end
end
