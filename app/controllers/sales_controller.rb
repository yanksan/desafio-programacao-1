class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def upload
    uploaded_file = params[:file]
    if uploaded_file.empty?
      respond_to do |format|
        format.html { redirect_to root_url, error: t('error_upload_notice') }
        format.json { head :no_content }
      end
    else
      File.open(uploaded_file).each_with_index do |line, i|
        if i > 0 # All lines without the head of file
          sale = Sale.new 
          line.split("\t").each_with_index do |field, i|
            sale.purchaser_name = field if i == 0
            sale.item_description = field if i == 1
            sale.item_price = field if i == 2
            sale.purchase_count = field if i == 3
            sale.merchant_address = field if i == 4
            sale.merchant_name = field if i == 5
          end
          sale.file_name = uploaded_file
          sale.save
          SalesUser.create(user: current_user, sale: sale)
        end
      end

      respond_to do |format|
        format.html { redirect_to root_url, notice: t('sucess_upload_notice') }
        format.json { head :no_content }
      end
    end
  end

  # GET /sales
  # GET /sales.json
  def index
    user = User.find(current_user)
    @sales = user.sales.all
    @sale_files = @sales.group_by { |t| t.file_name }

    #@sales_sum = @sales.group(:file_name).sum('item_price * purchase_count')
    #logger.info "@sales_sum: #{@sales_sum}\n"
    #@sales_sum.each do |file, result|
    #  logger.info "file: #{file}\n"
    #  logger.info "result: #{result}\n"
    #end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    SalesUser.where('user_id = ? AND sale_id = ?', current_user, @sale).delete_all
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name, :file_name)
    end
end
