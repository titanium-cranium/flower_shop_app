# frozen_string_literal: true
require "money"

class OrderProcessor
  attr_reader :order, :flower

  def initialize(order:, flower:)
    @order = order
    @flower = flower
  end

  def process
    shipment = create_shipment
    bundles_with_cost = total_cost(shipment)
    { number: order.number,
      flower: flower.code,
      total: bundles_with_cost[:total],
      bundles: bundles_with_cost[:bundles] }
  end

  private

  def create_shipment
    bundle_sizes = flower.bundles.collect { |bundle| bundle[:number] }
    ShipmentGenerator.generate_shipment(number: order.number, sizes: bundle_sizes)
  end

  def total_cost(shipment)
    bundles = []
    shipment[:shipment].each do |bundle|
      bundle_cost(bundle)
      bundles << bundle
    end
    total = bundles.reduce(0) { |sum, bundle| sum + bundle[:price] }.round.format
    { total: total, bundles: bundles.each {|bundle| bundle[:price] = bundle[:price].round.format} }
  end

  def bundle_cost(bundle)
    bundle_cost = flower.bundles.select { |b| b[:number] == bundle[:size] }.first[:price]
    bundle[:price] = Money.new(bundle_cost * bundle[:bunches] * 100, "AUD")
    bundle
  end
end
