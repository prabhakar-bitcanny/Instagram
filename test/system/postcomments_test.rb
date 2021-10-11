require "application_system_test_case"

class PostcommentsTest < ApplicationSystemTestCase
  setup do
    @postcomment = postcomments(:one)
  end

  test "visiting the index" do
    visit postcomments_url
    assert_selector "h1", text: "Postcomments"
  end

  test "creating a Postcomment" do
    visit postcomments_url
    click_on "New Postcomment"

    fill_in "Content", with: @postcomment.content
    fill_in "Post", with: @postcomment.post_id
    fill_in "User", with: @postcomment.user_id
    click_on "Create Postcomment"

    assert_text "Postcomment was successfully created"
    click_on "Back"
  end

  test "updating a Postcomment" do
    visit postcomments_url
    click_on "Edit", match: :first

    fill_in "Content", with: @postcomment.content
    fill_in "Post", with: @postcomment.post_id
    fill_in "User", with: @postcomment.user_id
    click_on "Update Postcomment"

    assert_text "Postcomment was successfully updated"
    click_on "Back"
  end

  test "destroying a Postcomment" do
    visit postcomments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Postcomment was successfully destroyed"
  end
end
