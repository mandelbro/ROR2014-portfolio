require "test_helper"


feature "Visiting the Comment Section" do

  scenario "anonymous user visits comment section" do

    # When I visit /comments
    visit post_path(posts(:love_git))

    # Then the approved comments should be loaded
    page.find('.comment-list').text.must_include comments(:test).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.wont_include comments(:user_unapproved).content
  end

  scenario "user visits post he commented on section" do
    # Given a logged in user
    sign_in(:user)
    visit post_path(posts(:love_git))

    # Then the approved comments should be loaded
    page.find('.comment-list').text.must_include comments(:test).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.must_include comments(:user_unapproved).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.wont_include comments(:author_unapproved).content

  end

  scenario "editor visits comment section" do
    # Given a logged in user
    sign_in(:editor)
    visit post_path(posts(:love_git))

    # Then the approved comments should be loaded
    page.find('.comment-list').text.must_include comments(:test).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.must_include comments(:user_unapproved).content
    # And the unapproved comments should be hidden
    page.find('.comment-list').text.must_include comments(:author_unapproved).content
  end
end
