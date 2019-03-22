class SalesFile < ApplicationRecord
  has_one_attached :file
  has_many :sales, dependent: :delete_all

  serialize :erred_rows

  before_create :reset_erred_rows

  enum status: { 
    uploaded: 1,
    processing: 3,
    complete: 2,
    incomplete: 99
  }

  def num_erred_rows
    erred_rows.try(:size) || 0
  end

  def reset_erred_rows
    self.erred_rows = []
  end

  def total_price
    sales.sum(&:total_price)
  end
end
