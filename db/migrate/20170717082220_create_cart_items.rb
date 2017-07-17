class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 12
      t.float :cart_price
      t.references :cart
      t.references :product
      t.timestamps
    end
  end
end
