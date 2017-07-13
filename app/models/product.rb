class Product < ApplicationRecord
  has_many :order_details
  has_many :comments
  has_many :categori_products
end
