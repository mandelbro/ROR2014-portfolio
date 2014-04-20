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
    page.wont_have_field('Published')
  end

  scenario "editors can publish" do
    # Given an editor's account
    sign_in(:editor)

    # When I visit the new page
    visit new_project_path

    # There is a checkbox for published
    page.must_have_field('Published')

    # When I submit the form
    fill_in "Title", with: projects(:cr).title
    fill_in "Body", with: projects(:cr).body
    check "Published"
    click_on "Create Project"

    # Then the published project should be shown
    page.text.wont_include "Status: Unpublished"
    page.find('article.project').has_css? ".published"
  end

end
