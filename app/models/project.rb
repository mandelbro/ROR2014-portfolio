class Project < ActiveRecord::Base
  has_many :comments, as: :commentable
  include Commentable
end
