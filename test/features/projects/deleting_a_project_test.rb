require "test_helper"

feature "Deleting a project" do
  scenario "Editors users can delete any project with a click" do
    sign_in(:editor)
    # Given an existing project
    visit projects_path

    # When the delete link is clicked
    page.find(".work-grid #project_#{projects(:spt).id}").click_on "Delete"

    # Then the project is deleted
    page.must_have_content "Project was successfully deleted"
    page.wont_have_content projects(:spt).company

  end

  scenario "Authors can delete their own project with a click" do
    # Given an existing project
    sign_in(:author)
    visit project_path projects(:author_published)

    # When the delete link is clicked
    page.click_on "Delete"

    # Then the project is deleted
    page.must_have_content "Project was successfully deleted."
    page.wont_have_content projects(:author_published).company

  end

  scenario "Unauthorized users can't see the delete button" do
    # Given an unauthorized user
    # When they visit the projects index
    visit projects_path

    # Then they don't see the delete button
    page.find(".work-grid li:first-child").wont_have_css ".button[value='delete']"

  end

  scenario "unauthenticated site visitors cannot see the delete button" do
    visit project_path projects(:author_published)
    page.must_have_content projects(:author_published).company
    page.find('.project-options').wont_have_link "Delete"
  end

  scenario "unauthorized users cannot see the delete button" do
    # Given I'm logged in as an author
    sign_in(:author)

    # When I visit a project that I didn't create
    visit project_path projects(:spt)

    # I should not see the Delete button
    page.must_have_content projects(:spt).company
    page.find('.project-options').wont_have_content "Delete"
  end

end
