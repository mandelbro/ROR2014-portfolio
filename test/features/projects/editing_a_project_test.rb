require "test_helper"

feature "Editing a project" do
  scenario "submit updates to an existing project" do
    sign_in(:author)
    visit projects_path
    page.find(".work-grid li:first").click_on "Edit"
    fill_in "Company", with: "Montes Enterprises"

    # When I submit the form
    click_on "Save"

    # Then a new project should be created and displayed
    page.text.must_include "Project \"Montes Enterprises\" was successfully updated."
    page.find("h1").text.must_include "Montes Enterprises"

  end

  scenario "Authors can edit their project" do
    # Given I view a project I created, logged in as an author
    sign_in(:author)
    visit project_path projects(:author_published)

    # When I click edit and submit changed data
    click_on "Edit"
    fill_in "Company", with: "Author Edited."
    click_on "Save"

    # Then the project is updated
    page.text.must_include "Project \"Author Edited.\" was successfully updated."
    page.text.must_include "Author Edited."
  end

  scenario "unauthorized users cannot see the edit button" do
    # Given I'm logged in as an author
    sign_in(:author)

    # When I visit a project that I didn't create
    visit project_path projects(:spt)

    # I should not see the Edit button
    page.must_have_content projects(:spt).company
    page.wont_have_link "Edit"
  end

  scenario "unauthenticated site visitors cannot see edit project button" do
    # Given I visit any project
    visit projects_path
    # Then project listings on the index page should not have edit links
    page.find(".work-grid #project_#{projects(:spt).id}").wont_have_link "Edit"
    # When I click on one of the projects
    page.find('.work-grid').click_on projects(:spt).company
    # Then I should not see the "New Project" button
    page.find(".project-options").wont_have_link "Edit"
  end
end
