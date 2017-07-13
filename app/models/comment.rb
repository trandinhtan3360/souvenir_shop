class Comment < ApplicationRecord
  belongs_to :user 
  belongs_to :product
  has_many :orders, through: :user
end
