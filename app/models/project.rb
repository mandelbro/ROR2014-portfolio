class Project < ActiveRecord::Base
  include Commentable

  belongs_to :user
  has_many :comments, as: :commentable

  mount_uploader :lead_image, ImageUploader

  validates :company, presence: true, uniqueness: true
end
