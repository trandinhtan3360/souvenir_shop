class PaymentMethod < ApplicationRecord
  has_many :transactions
  has_many :orders
end
