class Product < ApplicationRecord
  has_many :order_detail 
  has_many :comment
  has_many :categori_product
  has_many :order_items
  
  default_scope { where(active: true) }
end
