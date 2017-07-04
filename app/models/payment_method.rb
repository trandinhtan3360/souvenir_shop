class PaymentMethod < ApplicationRecord
  has_many :transactions
end
