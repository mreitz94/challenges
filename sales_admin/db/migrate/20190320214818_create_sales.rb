class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :sales_file, foreign_key: true
      t.string :customer_name
      t.string :item_description
      t.decimal :item_price, precision: 10, scale: 2
      t.integer :quantity
      t.string :merchant_name
      t.string :merchant_address

      t.timestamps
    end
  end
end
