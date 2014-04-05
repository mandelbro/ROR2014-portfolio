require "test_helper"

feature "Deleting a comment" do
  scenario "Editors can delete any comment with a click" do
    # Given an existing post with comments
    sign_in(:editor)
    visit posts(:love_git)

    # When the delete link is clicked
    page.find(".comment-list #{comments(:test).id}").click_on "Delete"

    # Then the comment is deleted
    page.must_have_content "Comment was successfully deleted."
    page.find('.comment-list').wont_have_content comments(:test).body

  end

  scenario "Users can delete their own any comment with a click" do
    # Given an existing comment
    sign_in(:user)
    visit posts(:love_git)

    # When the delete link is clicked
    page.find(".comment-list #{comments(:user_test).id}").click_on "Delete"

    # Then the comment is deleted
    page.must_have_content "Comment was successfully deleted."
    page.find('.comment-list').wont_have_content comments(:test).body

  end

  scenario "unauthenticated site visitors cannot see the delete button" do
    visit posts(:love_git)
    page.must_have_content comments(:test).body
    page.find(".comment-list #{comments(:test).id}").wont_have_content "Delete"
  end

  scenario "unauthorized users cannot see the delete button" do
    # Given I'm logged in as an author
    sign_in(:user)

    # When I visit a comment that I didn't create
    visit posts(:love_git)

    # I should not see the Delete button
    page.must_have_content comments(:cr).body
    page.find(".comment-list #{comments(:test).id}").wont_have_content "Delete"
  end

end
