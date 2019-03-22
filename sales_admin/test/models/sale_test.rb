require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  test "#total_price with item_price and quantity" do
    sale = Sale.new(item_price: 10.00, quantity: 2)
    assert_equal sale.total_price, 20.0
  end

  test "#total_price with item_price and 0 quantity" do
    sale = Sale.new(item_price: 10.00, quantity: 0)
    assert_equal sale.total_price, 0
  end
end
