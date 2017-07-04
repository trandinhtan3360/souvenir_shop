class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user
      t.string :full_name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
