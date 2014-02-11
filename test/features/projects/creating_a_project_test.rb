require "test_helper"

feature "Creating a Project" do
  scenario "submit form data to create a new project" do
    # Given a completed new project form
    visit new_project_path
    fill_in "Title", with: projects(:spt).title
    fill_in "Body", with: projects(:spt).body
    fill_in "Technologies", with: projects(:spt).Technologies
    fill_in "Lead Image", with: projects(:spt).lead_image

    # When I submit the form
    click_on "Create Project"

    # Then a new project should be created and displayed
    page.text.must_include "Project was successfully created"
    page.text.must_include projects(:cr).title
  end
end
