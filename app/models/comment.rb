class Comment < ActiveRecord::Base
  include Rakismet::Model

  belongs_to :post
  belongs_to :user
end
