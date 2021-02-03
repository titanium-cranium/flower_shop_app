# frozen_string_literal: true

require_relative '../../lib/shipment_generator'

RSpec.describe ShipmentGenerator do
  describe '.generate_shipment' do
    context 'a valid order is submitted' do
      let(:number) { 15 }
      let(:sizes) { [10, 5] }
      let(:shipment) { { shipment: [{ size: 10, bunches: 1 }, { size: 5, bunches: 1 }], remainder: 0 } }

      it 'returns a valid shipment with no remainder' do
        expect(ShipmentGenerator.generate_shipment(number: number, sizes: sizes)).to eq(shipment)
      end
    end

    context 'a more complex order is submitted' do
      let(:number) { 13 }
      let(:sizes) { [9, 5, 3] }
      let(:shipment) do
        { shipment: [{ size: 5, bunches: 2 }, { size: 3, bunches: 1 }], remainder: 0 }
      end

      it 'returns a valid shipment with no remainder' do
        expect(ShipmentGenerator.generate_shipment(number: number, sizes: sizes)).to eq(shipment)
      end
    end

    context 'an invalid order is submitted' do
      let(:number) { 19 }
      let(:sizes) { [10, 5] }
      let(:message) { 'Order for 19 cannot be fulfilled' }

      it 'returns an error message' do
        expect(ShipmentGenerator.generate_shipment(number: number, sizes: sizes)).to eq(message)
      end
    end
  end
end
