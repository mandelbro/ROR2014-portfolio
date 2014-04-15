require "test_helper"

feature 'As a user
        I want to be able to sign up for an account
        so that I can perform actions that require me to be logged in' do
  scenario "user submits registration form" do
    # Given a registration form
    visit new_user_registration_path

    # When I submit the login form with valid info
    fill_in "Username", with: "test_test_user"
    fill_in "Email", with: "testestst@testtest.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    page.find("form").click_on "Sign up"

    # Then I should be signed up
    page.text.must_include "Welcome! You have signed up successfully."
    page.text.wont_include "error prohibited this user from being saved"
    page.text.wont_include "errors prohibited this user from being saved"
  end
end
