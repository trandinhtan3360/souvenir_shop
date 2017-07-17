class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :quantity
      t.float :price
      t.integer :number_of_order, default: 12

      t.timestamps
    end
  end
end
