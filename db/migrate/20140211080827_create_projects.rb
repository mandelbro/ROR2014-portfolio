class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :company
      t.text :body
      t.text :technologies
      t.string :lead_image
      t.text :other_images
      t.text :quote
      t.string :quote_attr
      t.integer :weight

      t.timestamps
    end
  end
end
