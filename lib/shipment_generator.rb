class ShipmentGenerator
  def self.generate_shipment(number:, sizes:)
    shipment = bunch_picker(number: number, sizes: sizes)
    invalid_order = shipment[:remainder] != 0
    while invalid_order
      sizes.shift
      if sizes.empty?
        shipment = "Order for #{number} cannot be fulfilled"
        break
      end
      shipment = bunch_picker(number: number, sizes: sizes)
      invalid_order = shipment[:remainder] != 0
    end
    shipment
  end

  def self.bunch_picker(number:, sizes:)
    shipment = []
    remainder = 0
    sizes = sizes.sort.reverse

    sizes.each do |size|
      bunches, remainder = number.divmod(size)
      bunch = { size: size, bunches: bunches }
      shipment << bunch
      number = remainder
    end
    { shipment: shipment, remainder: remainder }
  end
end