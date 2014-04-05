require "test_helper"

feature "Creating a Comment" do

  scenario "submit form data to create a new comment" do
    # Given a user viewing a post
    sign_in(:user)
    visit posts(:love_git)
    click_on "Comment"

    # When I submit the form
    fill_in "Body", with: "ME TOO LOLOLO"

    # Then a new comment should be created and displayed
    page.text.must_include "Comment was successfully created"
    page.find('.comments .comment:last-child').text.must_include "ME TOO LOLOLO"
    page.text.must_include "Status: Unpublished"
    page.find('article.comment').has_css? ".unpublished"
  end

  scenario "unauthenticated site visitors cannot see new comment button" do
    # When I visit the blog index page
    visit posts(:love_git)
    # Then I should not see the "New Comment" button
    page.wont_have_link "Comment"
  end

end
