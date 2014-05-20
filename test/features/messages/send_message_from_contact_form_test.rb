require "test_helper"

feature "Sending a message from the contact form" do

  scenario "submit form data to create a new message" do
    # Given a user visits the contact form
    visit root_path
    find('.top-bar-section').click_on "Get in touch"

    # When I submit the form
    find('#new_message').fill_in "Name", with: "Test"
    find('#new_message').fill_in "Email", with: "test@test.com"
    find('#new_message').fill_in "Content", with: "Test content"
    find('#new_message').click_on "Send"

    # Then a new message should be created and displayed
    page.text.must_include "Thanks for your message, I'll get back to you as soon as I can."
  end

end
