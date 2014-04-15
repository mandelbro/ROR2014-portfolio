require "test_helper"

feature "Approve a comment" do
  scenario "Editors can approve any comment with a click" do
    # Given an existing post with comments
    sign_in(:editor)
    visit post_path(posts(:love_git))

    # When the delete link is clicked
    page.find(".comment-list #comment-#{comments(:user_unapproved).id}").click_on "Approve"

    # Then the comment is deleted
    page.must_have_content "Comment was successfully approved."
    page.find(".comment-list #comment-#{comments(:user_unapproved).id}").wont_have_content "Approve"

  end

  scenario "Editors can mark any comment as spam" do
    # Given an existing post with comments
    sign_in(:editor)
    visit post_path(posts(:love_git))

    # When the delete link is clicked
    page.find(".comment-list #comment-#{comments(:user_unapproved).id}").click_on "Mark as spam"

    # Then the comment is deleted
    page.must_have_content "Comment was successfully marked as spam."
    page.find('.comment-list').has_css? "#comment-#{comments(:user_unapproved).id}"

  end

end
