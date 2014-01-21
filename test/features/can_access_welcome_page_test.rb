require 'test_helper'

class CanAccessWelcomePageTest < Capybara::Rails::TestCase
  test 'It has a welcome headline' do
    visit root_path
    assert_content page, 'I make websites with my bear hands'
    refute_content page, 'Goobye All!'
  end
end
