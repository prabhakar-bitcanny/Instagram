require "test_helper"

class PostcommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postcomment = postcomments(:one)
  end

  test "should get index" do
    get postcomments_url
    assert_response :success
  end

  test "should get new" do
    get new_postcomment_url
    assert_response :success
  end

  test "should create postcomment" do
    assert_difference('Postcomment.count') do
      post postcomments_url, params: { postcomment: { content: @postcomment.content, post_id: @postcomment.post_id, user_id: @postcomment.user_id } }
    end

    assert_redirected_to postcomment_url(Postcomment.last)
  end

  test "should show postcomment" do
    get postcomment_url(@postcomment)
    assert_response :success
  end

  test "should get edit" do
    get edit_postcomment_url(@postcomment)
    assert_response :success
  end

  test "should update postcomment" do
    patch postcomment_url(@postcomment), params: { postcomment: { content: @postcomment.content, post_id: @postcomment.post_id, user_id: @postcomment.user_id } }
    assert_redirected_to postcomment_url(@postcomment)
  end

  test "should destroy postcomment" do
    assert_difference('Postcomment.count', -1) do
      delete postcomment_url(@postcomment)
    end

    assert_redirected_to postcomments_url
  end
end
