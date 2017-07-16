class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal # tra ve tpng gia tri cua don hang
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end
private
  def set_order_status #set product_id khoi tao hay chua 
    self.order_status_id = true
  end

  def update_subtotal #luu tong gia tri cua viec order
    self[:subtotal] = subtotal
  end
end
