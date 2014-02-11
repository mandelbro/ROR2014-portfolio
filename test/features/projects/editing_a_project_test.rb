require "test_helper"

feature "Editing a project" do
  scenario "submit updates to an existing project" do
    visit projects_path
    page.find(".work-grid li:first").click_on "Edit"
    fill_in "Company", with: "Montes Enterprises"

    # When I submit the form
    click_on "Save Project"

    # Then a new project should be created and displayed
    page.text.must_include "Project \"Montes Enterprises\" was successfully updated."
    page.find("h1").text.must_include "Montes Enterprises"

  end
end
