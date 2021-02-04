# frozen_string_literal: true

require 'json'
require_relative '../../lib/flower_shop_app'

RSpec.describe 'integration' do
  let(:orders) do
    [Order.new(number: 10, code: 'R12'),
     Order.new(number: 15, code: 'L09'),
     Order.new(number: 13, code: 'T58')]
  end

  let(:flowers) do
    [Flower.new(name: 'Roses', code: 'R12', bundles: [{ "number": 5, "price": 6.99 },
                                                      { "number": 10, "price": 12.99 }]),
     Flower.new(name: 'Lilies', code: 'L09', bundles: [{ "number": 3, "price": 9.95 },
                                                       { "number": 6, "price": 16.95 },
                                                       { "number": 9, "price": 24.95 }]),
     Flower.new(name: 'Tulips', code: 'T58', bundles: [{ "number": 3, "price": 5.95 },
                                                       { "number": 5, "price": 9.95 },
                                                       { "number": 9, "price": 16.99 }])]
  end

  let(:expected_result) do
    [
      { "number": 10, "flower":  'R12', "total":  '$12.99',
        "bundles": [{ "bunches": 1, "size": 10, "price": '$12.99' }] },
      { "number": 15, "flower":  'L09', "total":  '$41.90',
        "bundles": [{ "bunches": 1, "size": 9, "price": '$24.95' }, { "bunches": 1, "size": 6, "price": '$16.95' }] },
      { "number": 13, "flower":  'T58', "total":  '$25.85',
        "bundles": [{ "bunches": 2, "size": 5, "price": '$19.90' }, { "bunches": 1, "size": 3, "price": '$5.95' }] }
    ]
  end

  subject(:result) do
    FlowerShopApp.call(orders, flowers)
  end

  it 'outputs the correct shipment configuration' do
    expect(result).to eq(expected_result)
  end
end
