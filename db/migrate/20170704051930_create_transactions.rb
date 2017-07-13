class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :payment_method
      t.references :orders
      t.string :status
      t.string :amount

      t.timestamps
    end
  end
end
