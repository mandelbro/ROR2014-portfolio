class AddJunkToComments < ActiveRecord::Migration
  def change
    add_column :comments, :junk, :boolean
  end
end
