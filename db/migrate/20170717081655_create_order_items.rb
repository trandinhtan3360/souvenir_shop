class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.float :order_price
      t.references :product
      t.references :order

      t.timestamps
    end
  end
end
