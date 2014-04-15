require "test_helper"

feature 'As a site visitor
I want to write a comment from a blog post page
so that I can troll the author' do

  scenario "user signs in with twitter" do
    # Given a user on the login page
    visit new_user_session_path
    # configure OmniAuth
    OmniAuth.config.test_mode = true
    Capybara.current_session.driver.request.env['devise.mapping'] = Devise.mappings[:user]
    Capybara.current_session.driver.request.env['omniauth.auth'] = Devise.mappings[:user]
    OmniAuth.config.add_mock(:twitter, {
                               uid: '12345',
                               info: { nickname: 'test_twitter_user' }
                             })

    # When I click sign in with twitter
    click_on "Sign in with Twitter"
    save_and_open_page

    # I am now signed in
    page.text.must_include "test_twitter_user, you are signed in!"

  end

end
