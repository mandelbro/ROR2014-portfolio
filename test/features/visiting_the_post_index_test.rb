require "test_helper"


feature "Visiting the Post Index" do
  scenario "" do

    # When I visit /posts
    visit posts_path

    # Then the existing posts should be loaded
    page.text.must_include "Why I love Git"
  end
end
