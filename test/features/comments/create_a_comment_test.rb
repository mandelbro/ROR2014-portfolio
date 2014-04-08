require "test_helper"

feature "Creating a Comment" do

  scenario "submit form data to create a new comment" do
    # Given a user viewing a post
    sign_in(:user)
    visit post_path(posts(:love_git))

    # When I submit the form
    find('#new_comment').fill_in "Content", with: "ME TOO LOLOLO"
    find('#new_comment').click_on "Comment"

    # Then a new comment should be created and displayed
    page.text.must_include "Comment was successfully created"
    page.find('.comment-list .comment-item:last-child').text.must_include "ME TOO LOLOLO"
    page.find('.comment-list .comment-item:last-child').text.must_include "Status: Unapproved"
    page.find('.comment-list .comment-item:last-child').has_css? ".unapproved"
  end

  scenario "unauthenticated site visitors cannot see new comment button" do
    # When I visit the blog index page
    visit post_path(posts(:love_git))
    # Then I should not see the "New Comment" button
    page.wont_have_link "Comment"
  end

end
