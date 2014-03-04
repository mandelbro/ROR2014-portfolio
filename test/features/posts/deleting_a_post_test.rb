require "test_helper"

feature "Deleting a post" do
  scenario "Editors can delete any post with a click" do
    # Given an existing post
    sign_in(:editor)
    visit posts_path
    page.find(".post-list").click_on posts(:hate_git).title

    # When the delete link is clicked
    page.click_on "Delete"

    # Then the post is deleted
    page.must_have_content "Post was successfully deleted."
    page.wont_have_content posts(:hate_git).title

  end

  scenario "Authors can delete their own any post with a click" do
    # Given an existing post
    sign_in(:author)
    visit post_path posts(:author_published)

    # When the delete link is clicked
    page.click_on "Delete"

    # Then the post is deleted
    page.must_have_content "Post was successfully deleted."
    page.wont_have_content posts(:hate_git).title

  end

  scenario "unauthenticated site visitors cannot see the delete button" do
    visit post_path posts(:cr)
    page.must_have_content posts(:cr).title
    page.must_have_content posts(:cr).body
    page.wont_have_content "Delete"
  end

  scenario "unauthorized users cannot see the delete button" do
    # Given I'm logged in as an author
    sign_in(:author)

    # When I visit a post that I didn't create
    visit post_path posts(:cr)

    # I should not see the Delete button
    page.must_have_content posts(:cr).title
    page.must_have_content posts(:cr).body
    page.wont_have_content "Delete"
  end

  scenario "unauthenticated site visitors cannot see delete post button" do
    # When I visit any post
    visit posts_path
    page.find('.post-list').click_on posts(:cr).title
    # Then I should not see the "New Post" button
    page.find('.post-options').wont_have_link "Delete"
  end

end
