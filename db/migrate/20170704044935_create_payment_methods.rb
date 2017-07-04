class CreatePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_methods do |t|
      t.string :payment_name
      t.string :config
      t.string :description
      t.string :payment
      t.string :payment_info
      t.string :security
      t.string :message

      t.timestamps
    end
  end
end
