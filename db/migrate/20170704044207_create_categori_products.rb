class CreateCategoriProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :categori_products do |t|
      t.references :categori, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
