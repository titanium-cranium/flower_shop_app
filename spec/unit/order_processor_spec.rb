# frozen_string_literal: true

require_relative '../../lib/order_processor'
require_relative '../../lib/flower'
require_relative '../../lib/order'

RSpec.describe OrderProcessor do
  describe '#process' do
    let(:order) { Order.new(number: 13, code: 'T58') }

    let(:flower) do
      Flower.new(name: 'Tulips', code: 'T58', bundles: [
                   { "number": 3, "price": 5.95 },
                   { "number": 5, "price": 9.95 },
                   { "number": 9, "price": 16.99 }
                 ])
    end

    let(:op) do
      OrderProcessor.new(order: order, flower: flower)
    end

    let(:result) do
      { number: 13, flower: 'T58', "total": "$25.85", "bundles": [{ "bunches": 2, "size": 5, "price": "$19.90" }, { "bunches": 1, "size": 3, "price": "$5.95" }] }
    end

    describe 'given an order and flower' do
      it 'processes the order' do
        expect(op.process).to eq(result)
      end
    end
  end
end
