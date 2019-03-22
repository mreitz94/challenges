class AddColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_files, :status, :integer
    add_column :sales_files, :erred_rows, :text
  end
end
