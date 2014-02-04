require "test_helper"

feature "Check for Zurb" do
  scenario "Access the welcome page" do
    # Given I access the welcome page
    visit root_path

    # When I search the markup
    # The columns class is used
    page.must_have_selector(".row .columns")
  end
end
