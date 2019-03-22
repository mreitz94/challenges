class SalesFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sales_file, only: [:show, :update, :destroy, :process_file]
  before_action :set_erred_sales, only: [:show]

  # GET /sales_files
  def index
    @sales_files = SalesFile.all
  end

  # GET /sales_files/1
  def show
  end

  # GET /sales_files/new
  def new
    @sales_file = SalesFile.new
  end

  # POST /sales_files
  def create
    @sales_file = SalesFile.new(sales_file_params)

    respond_to do |format|
      if @sales_file.save
        @sales_file.uploaded!
        format.html { redirect_to @sales_file, notice: 'Sales file was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /sales_files/1
  def destroy
    @sales_file.destroy
    respond_to do |format|
      format.html { redirect_to sales_files_url, notice: 'Sales file was successfully destroyed.' }
    end
  end

  # PATCH /sales_files/1/process
  def process_file
    if SalesFileProcessor.new(@sales_file).process
      flash[:notice] = 'Sales file was successfully processed.'
    else
      flash[:alert] = 'Sales file was processed with errors.'
    end
    redirect_to @sales_file
  end

  private

  def set_sales_file
    @sales_file = SalesFile.find(params[:id])
  end

  def sales_file_params
    params.require(:sales_file).permit(:description, :file)
  end

  def set_erred_sales
    @erred_sales = []
    return unless @sales_file.erred_rows
    @erred_sales = @sales_file.erred_rows.map do |s|
      sale = Sale.new(s)
      sale.sales_file_id = @sales_file.id
      sale.valid?
      sale
    end
  end
end
