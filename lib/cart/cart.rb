class Cart
  attr_reader :items

  class << self
    def build_from_hash hash
      items = if hash
        hash["items"].map do |items_data|
          CartItem.new items_data["product_id"],
            items_data["quantily"]
          end
        else
          Array.new
        end
      new items
    end
  end

  def initialize items = []
    @items = items
  end

  def add_items product_id, quantily
    item = @items.find{|item| item.product_id == product_id}
    if item
      item.increment
    else
      @items << CartItem.new(product_id, quantily)
    end
  end

  def find_item product_id
    @items.find{|item| item.product_id == product_id}
  end

  def empty?
    @items.empty?
  end

  def count
    @items.length
  end

  def total_price
    @items.inject(0){ |sum, item| sum + item.total_price}
  end

  def sort
    items = @items.map do |item|
      {product_id: item.product_id, quantily: item.quantity}
    end
    {items: items}
  end
end
