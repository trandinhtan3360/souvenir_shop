class Comment < ApplicationRecord
  belogs_to :user 
  belogs_to :product
end
