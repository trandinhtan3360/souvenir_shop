class CreateCategoris < ActiveRecord::Migration[5.1]
  def change
    create_table :categoris do |t|
      t.string :name
      t.string :sort_order

      t.timestamps
    end
  end
end
