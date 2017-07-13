class Product < ApplicationRecord
  has_many :order_details
  has_many :comments
  has_many :category_products
  mount_uploader :image, ImageUploader
end
