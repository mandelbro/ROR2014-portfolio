require "test_helper"


feature "An index page displaying all projects" do
  scenario "Visiting the Project Index" do

    # When I visit /projects
    visit projects_path

    # Then the existing projects should be loaded
    page.find(".work-grid").text.must_include projects(:spt).company
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
