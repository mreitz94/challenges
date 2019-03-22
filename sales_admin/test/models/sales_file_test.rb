require 'test_helper'

class SalesFileTest < ActiveSupport::TestCase
  test "#has_many sales" do
    sales_file = sales_files(:one)
    sales = [sales(:one), sales(:two)]
    assert_equal sales_file.sales.count, 2
  end

  test "#num_erred_rows" do
    sales_file = sales_files(:one)
    assert_equal sales_file.num_erred_rows, 0
    
    sales_file.erred_rows = [{ quantity: -1 }]
    assert_equal sales_file.num_erred_rows, 1
  end

  test "#erred_rows" do
    sales_file = SalesFile.new
    sales_file.save
    assert_equal sales_file.erred_rows, []
  end

  test "#total_price with sales" do
    sales_file = sales_files(:one)
    expected_total_price = [sales(:one), sales(:two)].map { |s| s.quantity * s.item_price }.sum
    assert_equal sales_file.total_price, expected_total_price
  end

  test "#total_price without sales" do
    sales_file = sales_files(:two)
    assert_equal sales_file.total_price, 0.0
  end
end
