class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.references :product
      t.references :orders
      t.string :quantity
      t.string :price

      t.timestamps
    end
  end
end
