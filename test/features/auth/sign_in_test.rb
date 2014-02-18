require "test_helper"

feature 'As a user
         I want to sign in with my account details
         so that the website allows me to perform the actions of an authenticated user' do
  scenario "user signs in to website with correct details" do
    # Given a registration form
    visit "/"
    page.find('#header').click_on "Sign In"

    # When I register with valid info
    fill_in "Email", with: "rewt@test.com"
    fill_in "Password", with: "password"

    page.find("form").click_on "Sign in"

    # Then I should be signed up
    page.text.must_include "Signed in successfully."
    page.text.wont_include "Sign In"
    page.text.wont_include "Invalid email or password."
  end
end
