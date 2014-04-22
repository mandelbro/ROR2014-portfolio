class Project < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  include Commentable
end
