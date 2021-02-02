require 'json'

task :default => [:run]

task 'run' do
  $LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')
  require 'flower_shop_app'

  orders = File.readlines('data/orders.txt').map { |line| line.chomp.split(' ') }
  flowers = JSON.parse(File.read('data/flowers.json'))
  result_json = FlowerShopApp.call(orders, flowers)
  pp result_json
end
