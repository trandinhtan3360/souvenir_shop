class Order < ApplicationRecord
  has_many :order_details
  has_many :transactions
  belogs_to :user
  has_many :comments, through: :user
  has_many :products, through: :order_detail
  has_many :payment_methods, through: :transactions
end
