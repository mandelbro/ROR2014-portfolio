class Comment < ActiveRecord::Base
  include Rakismet::Model

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
