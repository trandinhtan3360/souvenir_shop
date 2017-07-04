class Order < ApplicationRecord
  has_many :order_detail
  has_many :transactions
  belogs_to :user
  has_many :comment, through: :user
  has_many :product, through: :order_detail
  has_many :payment_method, through: :transactions
end
