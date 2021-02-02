require 'order'
require 'flower'

class FlowerShopApp
  def self.call(orders, flowers)
    @orders = orders.map { |order| Order.new(number: order[0], code: order[1]) }
    @flowers = flowers.map { |flower| Flower.new(name: flower['name'], code: flower['code'], bundles: flower['bundles']) }
  end
end
