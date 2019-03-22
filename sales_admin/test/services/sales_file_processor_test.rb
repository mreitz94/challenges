require 'test_helper'

class SalesFileProcessorTest < ActiveSupport::TestCase
  test "PERMITTED_KEYS" do
    assert_equal(
      SalesFileProcessor::PERMITTED_KEYS,
      %w[customer_name item_description item_price quantity merchant_name merchant_address]
    )
  end

  test "#process" do
    sales_file = SalesFile.new
    build_valid_file sales_file
    SalesFileProcessor.new(sales_file).process

    assert_equal sales_file.sales.count, 5
    assert_equal sales_file.total_price, 526.45
    assert_equal sales_file.erred_rows, []
    assert sales_file.complete?
  end

  test "#process with invalid file" do
    sales_file = SalesFile.new
    build_invalid_file sales_file
    SalesFileProcessor.new(sales_file).process

    assert_equal sales_file.sales.count, 3
    assert_equal sales_file.erred_rows.size, 2
    assert sales_file.incomplete?
  end

  test "#process with blank file" do
    sales_file = SalesFile.new
    build_blank_file sales_file
    SalesFileProcessor.new(sales_file).process

    assert_equal sales_file.sales.count, 0
    assert_equal sales_file.erred_rows.size, 0
    assert_equal sales_file.total_price, 0
    assert sales_file.complete?
  end

  def build_valid_file(sales_file)
    sales_file.file.attach(
      io: File.open(Rails.root.join('test', 'files', 'valid_file.csv')),
      filename: 'file.csv',
      content_type: 'csv')
  end

  def build_invalid_file(sales_file)
    sales_file.file.attach(
      io: File.open(Rails.root.join('test', 'files', 'invalid_file.csv')),
      filename: 'invalid_file.csv',
      content_type: 'csv')
  end

  def build_blank_file(sales_file)
    sales_file.file.attach(
      io: '',
      filename: 'invalid_file.csv',
      content_type: 'csv')
  end
end
