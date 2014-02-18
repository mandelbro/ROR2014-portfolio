require "test_helper"

feature "Editing a post" do
  scenario "submit updates to an existing post" do
    # Given an existing post
    sign_in
    post = Post.create(title: "Why I love Git", body: "It works using imageMagick.")
    visit post_path(post)

    # When I click edit and submit changed data
    click_on "Edit"
    fill_in "Title", with: "It works using real magic."
    click_on "Update Post"

    # Then the post is updated
    page.text.must_include "Post was successfully updated"
    page.text.must_include "It works using real magic"
    # Todo: get this working
    # page.has_css? "#author"
    # page.text.must_include users(:rewt).email # Use your fixture name here.

  end
end
