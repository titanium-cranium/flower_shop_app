require 'order'

class FlowerShopApp
  def self.call(orders)
    @orders = orders.map { |order| Order.new(number: order[0], code: order[1]) }
  end
end
