require "test_helper"

feature "Deleting a post" do
  scenario "post is deleted with a click" do
    # Given an existing post
    sign_in
    visit posts_path

    # When the delete link is clicked
    page.find("tbody tr:last").click_on "Destroy"

    # Then the post is deleted
    page.wont_have_content "Why I hate Git"

  end
end
