class AddCommentableToComments < ActiveRecord::Migration
  def change
    add_belongs_to :comments, :commentable, index: true, polymorphic: true
  end
end
