require 'json'

task :default => [:run]

task 'run' do
  $LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')
  require 'flower_shop_app'

  orders = File.readlines('data/orders.txt').map { |line| line.chomp.split(' ') }
  result_json = FlowerShopApp.call(orders)
end
