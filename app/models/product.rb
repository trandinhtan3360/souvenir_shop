class Product < ApplicationRecord
  has_many :order_details
  has_many :comments
  has_many :categori_products

  def self.search(query)
    where("name like ?", "%#{query}%")
    where("price like ?", "%#{query}")
    where("comment like ?", "%#{query}")
  end
end
