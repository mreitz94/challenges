class CreateSalesFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_files do |t|
      t.string :description

      t.timestamps
    end
  end
end
