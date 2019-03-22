
module SalesFilesHelper
  def process_button(sales_file)
    text = sales_file.uploaded? ? 'Process' : 'Re-Process'
    link_to text, process_file_sales_file_path(sales_file), class: 'btn btn-warning'
  end
end
