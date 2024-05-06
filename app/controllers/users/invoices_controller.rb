# frozen_string_literal: true

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
    redirect_to users_invoices_url, alert: "You are not authorized to perform this action, invoice is paid you can't delete it" and return if @invoice.paid?

    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to users_invoices_url, notice: 'invoice was successfully destroyed.' }
    end
  end

  def paid
    redirect_to users_invoices_url, alert: 'You are not authorized to perform this action, please ask to admin or manager to update status' and return if current_user.role.name == 'Technician'

    @invoice.update(status: :paid, service_end_time: Time.zone.now)

    respond_to do |format|
      format.html { redirect_to users_invoices_url, notice: 'invoice was successfully paid.' }
    end
  end

  def search_customer
    customers = Customer.search_for(params[:email_search]) # .order(created_at: :desc)
    render json: customers.to_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:status, :price, :tax, :discount, :total_price, :transaction_id, :payment_method, :customer_id, :customer_name, :customer_phone, :customer_email, invoice_products_attributes: %i[id product_id quantity price final_price _destroy], invoice_services_attributes: %i[id name price _destroy])
  end
end
