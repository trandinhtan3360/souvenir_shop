class Product < ApplicationRecord
  has_many :order_details
  has_many :comments
  has_many :category_products
  mount_uploader :image, ImageUploader

  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
    numericality: { greater_than: 0, less_than: 1000000 }
  validate :image_size_validation, :if => "image?"

  def image_size_validation
    if image.size > Setting.image.megabytes
      errors.add(:base, t(".message"))
    end
  end
end
