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

  scenario "Authors can delete their own any project with a click" do
    # Given an existing project
    sign_in(:author)
    visit project_path projects(:author_published)

    # When the delete link is clicked
    page.click_on "Delete"

    # Then the project is deleted
    page.must_have_content "Project was successfully deleted."
    page.wont_have_content projects(:hate_git).title

  end

  scenario "unauthenticated site visitors cannot see the delete button" do
    visit project_path projects(:cr)
    page.must_have_content projects(:cr).title
    page.must_have_content projects(:cr).body
    page.wont_have_content "Delete"
  end

  scenario "unauthorized users cannot see the delete button" do
    # Given I'm logged in as an author
    sign_in(:author)

    # When I visit a project that I didn't create
    visit project_path projects(:cr)

    # I should not see the Delete button
    page.must_have_content projects(:cr).title
    page.must_have_content projects(:cr).body
    page.wont_have_content "Delete"
  end

  scenario "unauthenticated site visitors cannot see delete project button" do
    # When I visit any project
    visit projects_path
    page.find('.project-list').click_on projects(:cr).title
    # Then I should not see the "New Project" button
    page.find('.project-options').wont_have_link "Delete"
  end

end
