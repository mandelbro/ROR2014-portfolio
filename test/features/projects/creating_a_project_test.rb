require "test_helper"

feature "Creating a Project" do
  scenario "Author can submit form data to create a new project" do
    # Given a completed new project form
    sign_in(:author)

    # When I submit the form
    visit new_project_path
    fill_in_project_form({
      company: 'Author Test Company',
    })
    click_on "Create Project"

    # Then a new project should be created and displayed
    page.text.must_include "Project was successfully created"
    page.text.must_include "Author Test Company"
    page.text.must_include "Status: Unpublished"
    page.find('#project').has_css? ".unpublished"
  end

  scenario "unauthenticated site visitors cannot see new project button" do
    # When I visit the blog index page
    visit projects_path
    # Then I should not see the "New Project" button
    page.wont_have_link "New Project"
  end

  scenario "authors can't publish" do
    # Given an author's account
    sign_in(:author)

    # When I visit the new page
    visit new_project_path

    # There is no checkbox for published
    page.wont_have_field('Publish?')
  end

  scenario "editors can publish on save" do
    # Given an editor's account
    sign_in(:editor)

    # When I visit the new page
    visit new_project_path

    # There is a checkbox for published
    page.must_have_field('Publish?')

    # When I submit the form
    visit new_project_path
    fill_in_project_form({
      company: 'Editor Test Company'
    })
    check "Publish?"
    click_on "Create Project"

    # Then the published project should be shown
    page.text.must_include "Project was successfully created"
    page.text.wont_include "Status: Unpublished"
    page.find('#project').has_css? ".published"
  end

end
