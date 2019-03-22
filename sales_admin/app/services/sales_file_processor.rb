require 'csv'

class SalesFileProcessor
  PERMITTED_KEYS = %w[customer_name item_description item_price quantity merchant_name merchant_address]

  def initialize(sales_file)
    @sales_file = sales_file
    
  end

  def process
    pre_processing
    csv_parsing
    finish_processing
  end

  private

  def pre_processing
    @sales_file.processing!
    if @sales_file.num_erred_rows > 0
      @sales_file.reset_erred_rows
      @sales_file.save
    end
    @sales_file.sales.delete_all if @sales_file.sales.any?
  end

  def csv_parsing
    CSV.parse(@sales_file.file.download, headers: true) do |row|
      row = row.to_h
      row.keys.each do |key|
        new_key = key.to_s.downcase.gsub(/\s/, '_')
        row[new_key] = row[key]
        row.delete(key)
      end
      row.delete_if { |k,_| !k.in?(PERMITTED_KEYS) }

      puts row.inspect
      row['item_price'] = row['item_price'].to_f
      row['quantity'] = row['quantity'].to_i

      puts row.inspect

      begin
        sale = @sales_file.sales.new(row)
        unless sale.save
          @sales_file.erred_rows << row
        end
      rescue
        @sales_file.erred_rows << row
      end
    end
  end

  def finish_processing
    @sales_file.sales = @sales_file.sales.to_a.delete_if(&:invalid?)

    if @sales_file.erred_rows.any?
      @sales_file.incomplete!
      false
    else
      @sales_file.complete!
      true
    end
  end
end
