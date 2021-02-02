class Order
  attr_reader(:code, :number)

  def initialize(code:, number:)
    @code = code
    @number = number.to_i
  end
end
