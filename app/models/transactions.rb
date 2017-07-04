class Transactions < ApplicationRecord
  belogs_to :orders 
  belogs_to :payment_method
end
