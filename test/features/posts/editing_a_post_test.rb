require "test_helper"

feature "Editing a post" do
  scenario "Editors can edit any post" do
    # Given I view a post, logged in as an editor
    sign_in(:editor)
    visit post_path posts(:cr)

    # When I click edit and submit changed data
    click_on "Edit"
    fill_in "Title", with: "Edited."
    click_on "Update Post"

    # Then the post is updated
    page.text.must_include "Post was successfully updated"
    page.find('h1').text.must_include "Edited."
    page.has_css? "#author"
    page.text.must_include users(:root).username # Use your fixture name here.

  end

  scenario "Authors can edit their post" do
    # Given I view a post I created, logged in as an author
    sign_in(:author)
    visit post_path posts(:author_published)

    # When I click edit and submit changed data
    click_on "Edit"
    fill_in "Title", with: "Author Edited."
    click_on "Update Post"

    # Then the post is updated
    page.text.must_include "Post was successfully updated"
    page.text.must_include "Author Edited."
    page.has_css? "#author"
    page.text.must_include users(:author).username # Use your fixture name here.
  end

  scenario "unauthorized users cannot see the edit button" do
    # Given I'm logged in as an author
    sign_in(:author)

    # When I visit a post that I didn't create
    visit post_path posts(:cr)

    # I should not see the Edit button
    page.must_have_content posts(:cr).title
    page.must_have_content posts(:cr).body
    page.wont_have_link "Edit"
  end

  scenario "unauthenticated site visitors cannot see edit post button" do
    # When I visit any post
    visit posts_path
    page.find('.post-list').click_on posts(:cr).title
    # Then I should not see the "New Post" button
    page.find('.post-options').wont_have_link "Edit"
  end
end
