require "test_helper"

feature "Creating a Comment" do

  scenario "submit form data to create a new comment" do
    # Given a user viewing a project
    sign_in(:user)
    visit project_path(projects(:upco))

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
    visit project_path(projects(:upco))
    # Then I should not see the "New Comment" button
    page.wont_have_link "Comment"
  end

end

feature "Visiting the Comment Index" do

  scenario "anonymous user visits comment index" do

    # When I visit /comments
    visit project_path(projects(:upco))

    # Then the approved comments should be loaded
    page.find('.comment-list').text.must_include comments(:test).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.wont_include comments(:user_unapproved).content
  end

  scenario "user visits project he commented on index" do
    # Given a logged in user
    sign_in(:user)
    visit project_path(projects(:upco))

    # Then the approved comments should be loaded
    page.find('.comment-list').text.must_include comments(:test).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.must_include comments(:user_unapproved).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.wont_include comments(:author_unapproved).content

  end

  scenario "editor visits comment index" do
    # Given a logged in user
    sign_in(:editor)
    visit project_path(projects(:upco))

    # Then the approved comments should be loaded
    page.find('.comment-list').text.must_include comments(:test).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.must_include comments(:user_unapproved).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.must_include comments(:author_unapproved).content
  end
end
