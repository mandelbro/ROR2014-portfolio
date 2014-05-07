class Project < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  include Commentable

  validates :company, presence: true, uniqueness: true
end
