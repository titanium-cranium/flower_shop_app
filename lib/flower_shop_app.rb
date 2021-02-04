require 'order'
require 'flower'
require 'shipment_generator'
require 'order_processor'

class FlowerShopApp
  def self.call(orders, flowers)
    Money.locale_backend = nil
    Money.rounding_mode=BigDecimal::ROUND_HALF_UP
    # orders = orders.map { |order| Order.new(number: order[0], code: order[1]) }
    # flowers = flowers.map { |flower| Flower.new(name: flower['name'], code: flower['code'], bundles: flower['bundles']) }
    process_orders(orders, flowers)
  end

  def self.process_orders(orders, flowers)
    receipt = []
    orders.each do |order|
      flower = flowers.select { |f| f.code == order.code }.first
      receipt << OrderProcessor.new(order: order, flower: flower).process
    end
    receipt
  end
end
