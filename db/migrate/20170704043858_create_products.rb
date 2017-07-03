class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.string :comment
      t.integer :discount
      t.string :image_link
      t.string :images_list
      t.integer :view

      t.timestamps
    end
  end
end
