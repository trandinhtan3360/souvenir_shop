class CreateOrderStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :order_statuses do |t|
      t.string :name
      t.string :rails
      t.string :g
      t.string :model
      t.string :OrderStatus
      t.string :name

      t.timestamps
    end
  end
end
