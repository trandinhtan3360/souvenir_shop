class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :phone
      t.string :address
      t.string :role
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin

      t.timestamps
    end
  end
end
