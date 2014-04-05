require "test_helper"


feature "Visiting the Comment Index" do

  scenario "anonymous user visits comment index" do

    # When I visit /comments
    visit posts(:love_git)

    # Then the published comments should be loaded
    page.text.must_include comments(:test).body
    # And the unpublished comments should be hidden
    page.text.wont_include comments(:user_unpublished).title
  end

  scenario "user visits post he commented on index" do
    # Given a logged in user
    visit posts(:love_git)

    # Then the published comments should be loaded
    page.text.must_include comments(:test).body
    # And the unpublished comments should be hidden
    page.text.must_include comments(:user_unpublished).title
    # And the unpublished comments should be hidden
    page.text.must_not_include comments(:author_unpublished).title

  end

  scenario "editor visits comment index" do
    # Given a logged in user
    visit posts(:love_git)

    # Then the published comments should be loaded
    page.text.must_include comments(:test).body
    # And the unpublished comments should be hidden
    page.text.must_include comments(:user_unpublished).title
    # And the unpublished comments should be hidden
    page.text.must_include comments(:author_unpublished).title
  end
end
