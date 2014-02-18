require "test_helper"

feature 'As a user
         I want to sign out of my account
         so that when I leave my information is secure' do
  scenario "user signs in to website, then signs out" do
    # Given I have signed into my account
    sign_in

    # When I click Sign out
    page.find('#header').click_on "Sign Out"

    # Then I should be signed up
    page.text.must_include "Signed out successfully."
    page.text.wont_include "Sign Out"
  end
end
