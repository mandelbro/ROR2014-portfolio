
# app/models/concerns/taggable.rb
# notice that the file name has to match the module name
# (applying Rails conventions for autoloading)
module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
  end

end
