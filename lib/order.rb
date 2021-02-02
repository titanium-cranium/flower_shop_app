class Order
  attr_accessor(:code, :number)

  def initialize(code:, number:)
    @code = code
    @number = number.to_i
  end
end
