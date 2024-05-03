class Users::InvoicesController < ApplicationController
	before_action :set_invoice, only: %i[show edit update destroy paid]

	def index
		@invoices = Invoice.all
	end

	def show; end

  def new
    @invoice = current_user.invoices.new(price: 0, tax: 0, discount: 0, total_price: 0)
  end

  def edit; end

  def create
    @invoice = current_user.invoices.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to users_invoices_path, notice: 'Invoice was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
	end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to users_invoices_url, notice: 'Invoice was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to users_invoices_url, notice: 'invoice was successfully destroyed.' }
    end
  end

  def paid
    redirect_to users_invoices_url, alert: 'You are not authorized to perform this action, please ask to admin to update status' and return if current_user.role.name != 'Admin'

    @invoice.update(status: :paid)

    respond_to do |format|
      format.html { redirect_to users_invoices_url, notice: 'invoice was successfully paid.' }
    end
  end

	private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:status, :price, :tax, :discount, :total_price, :transaction_id, :payment_method, invoice_products_attributes: %i[id product_id quantity price final_price _destroy])
  end
end
