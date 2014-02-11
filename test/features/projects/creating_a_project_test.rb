require "test_helper"

feature "Creating a Project" do
  scenario "submit form data to create a new project" do
    # Given a completed new project form
    visit projects_path
    click_on "New Project"
    fill_in "Company", with: projects(:spt).company
    fill_in "Body", with: projects(:spt).body
    fill_in "Technologies", with: projects(:spt).technologies
    fill_in "Lead image", with: projects(:spt).lead_image

    # When I submit the form
    click_on "Save Project"

    # Then a new project should be created and displayed
    page.text.must_include "Project was successfully created"
    page.text.must_include projects(:spt).company
  end
end
