require "test_helper"

feature "Deleting a project" do
  scenario "project is deleted with a click" do
    # Given an existing project
    visit projects_path

    # When the delete link is clicked
    page.find(".work-grid li:last").click_on "Destroy"

    # Then the project is deleted
    page.must_have_content "Project was successfully deleted"
    page.wont_have_content "Why I hate Git"

  end
end
