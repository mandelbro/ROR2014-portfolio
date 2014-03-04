class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  def publish!
    published = true
    save!
  end
end
