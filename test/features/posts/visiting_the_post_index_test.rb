require "test_helper"


feature "Visiting the Post Index" do

  scenario "anonymous user visits post index" do

    # When I visit /posts
    visit posts_path

    # Then the published posts should be loaded
    page.text.must_include posts(:cr).title
    # And the unpublished posts should be hidden
    page.text.wont_include posts(:author_unpublished).title
  end

  scenario "author visits post index" do
    # Given a logged in author
    sign_in(:author)
    # When I visit /posts
    visit posts_path

    # Then I should only see my own posts
    page.text.must_include posts(:author_published).title
    page.text.must_include posts(:author_unpublished).title
    page.text.wont_include posts(:cr).title
    page.text.wont_include posts(:love_git).title
    page.text.wont_include posts(:hate_git).title
  end

  scenario "editor visits post index" do
    # Given a logged in author
    sign_in(:editor)
    # When I visit /posts
    visit posts_path

    # Then I should all published and unpublished posts
    page.text.must_include posts(:author_published).title
    page.text.must_include posts(:author_unpublished).title
    page.text.must_include posts(:cr).title
    page.text.must_include posts(:love_git).title
  end
end
