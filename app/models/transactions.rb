class Transactions < ApplicationRecord
  belongs_to :orders 
  belongs_to :payment_method
end
