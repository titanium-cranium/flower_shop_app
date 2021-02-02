require 'json'
require 'flower_shop_app'


RSpec.describe 'integration' do

  let(:order) {['10 R12', '15 L09', '13 T58']}

  let(:expected_result_json) {
    <<~JSON
      [
        {"number":  10, "flower":  "R12", "total":  "$12.99", "bundles": {"number": 1, "size": 10 , "price": "$12.99" }},
        {"number":  15, "flower":  "L09", "total":  "$41.90", "bundles": [{"number": 1, "size": 9, "price": "$24.95" }, {"number": 1, "size": 6 , "price": "$16.95" }]},
        {"number":  13, "flower":  "T58", "total":  "$25.85", "bundles": [{"number": 2, "size": 5, "price": "$9.95" }, {"number": 1, "size": 3 , "price": "$5.95" }]}
      ]
    JSON
  }

  subject(:result) do
    json_result = FlowerShopApp.call(order)
    JSON.load(json_result)
  end

  it "outputs the correct shipment configuration" do
    expect(:result).to eq JSON.load(expected_result_json)
  end
end
