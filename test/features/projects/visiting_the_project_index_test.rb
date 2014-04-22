require "test_helper"


feature "An index page displaying all projects" do
  scenario "Visiting the Project Index" do

    # When I visit /projects
    visit projects_path

    # Then the existing projects should be loaded
    page.find(".work-grid").text.must_include projects(:spt).company
  end

  scenario "anonymous user visits project index" do

    # When I visit /projects
    visit projects_path

    # Then the published projects should be loaded
    page.text.must_include projects(:spt).company
    # And the unpublished projects should be hidden
    page.text.wont_include projects(:author_unpublished).company
  end

  scenario "author visits project index" do
    # Given a logged in author
    sign_in(:author)
    # When I visit /projects
    visit projects_path

    # Then I should only see my own projects
    page.text.must_include projects(:author_published).company
    page.text.must_include projects(:author_unpublished).company
    page.text.wont_include projects(:spt).company
    page.text.wont_include projects(:rmv).company
    page.text.wont_include projects(:upco).company
  end

  scenario "editor visits project index" do
    # Given a logged in author
    sign_in(:editor)
    # When I visit /projects
    visit projects_path

    # Then I should all published and unpublished projects
    page.text.must_include projects(:author_published).company
    page.text.must_include projects(:author_unpublished).company
    page.text.must_include projects(:spt).company
    page.text.must_include projects(:upco).company
  end
end

feature "Project Link in Navigation Menu" do
  scenario "Checking the text of the nav menu" do

    # When I visit /projects
    visit root_path

    menu = page.find('nav.top-bar')

    # Then the navigation menu should include a link to the projects page
    page.find('nav.top-bar a[href="/projects"]').text.must_include "Projects"
  end
  scenario "Clicking on the nav menu" do

    # When I visit /projects and click on Projects
    visit root_path
    page.find('nav.top-bar').click_on "Projects"

    # Then I should end up on the projects page
    page.find(".work-grid").text.must_include projects(:spt).company
  end
end
