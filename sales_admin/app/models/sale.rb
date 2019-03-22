class Sale < ApplicationRecord
  belongs_to :sales_file

  validates :customer_name, length: { maximum: 255 }
  validates :item_description, length: { maximum: 255 }
  validates :merchant_name, length: { maximum: 255 }
  validates :merchant_address, length: { maximum: 255 }
  validates :item_price, numericality: { greater_than: 0, less_than: 10_000_000 }
  validates :quantity, numericality: { integer: true, greater_than_or_equal_to: 0, less_than: 100_000_000 }

  def total_price
    item_price.to_f * quantity.to_f
  end
end
