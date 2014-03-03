require "test_helper"

feature "Deleting a post" do
  scenario "post is deleted with a click" do
    # Given an existing post
    sign_in
    visit posts_path
    page.find(".post-list").click_on posts(:hate_git).title

    # When the delete link is clicked
    page.click_on "Delete"

    # Then the post is deleted
    page.wont_have_content "Why I hate Git"

  end
end
