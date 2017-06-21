class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length:{ maximum: Settings.maximum }, presence: true
end
