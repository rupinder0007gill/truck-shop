# frozen_string_literal: true

class Users::InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy paid]
  load_and_authorize_resource

  def index
    @search_url = users_invoices_path
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction].presence_in(%w[asc desc]) || 'desc'

    @invoices = if params[:query].present?
                  Invoice.joins(:user, :customer).where('lower(customers.first_name) LIKE ? OR lower(customers.last_name) LIKE ? OR lower(users.first_name) LIKE ? OR lower(users.last_name) LIKE ?', "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%")
                else
                  Invoice.includes(%i[user customer]).all
                end
    @pagy, @invoices = pagy(@invoices.order("#{sort_column} #{sort_direction}"), items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream # Respond to Turbo Stream requests
    end
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

    @invoice.update(status: :paid, service_end_time: Time.zone.now, current_admin: current_user)

    respond_to do |format|
      format.html { redirect_to users_invoices_url, notice: 'invoice was successfully paid.' }
    end
  end

  def search_customer
    customers = Customer.search_for(params[:email_search]) # .order(created_at: :desc)
    render json: customers.to_json
  end

  def find_or_create_customer
    customer = Customer.find_by(email: params[:email])
    name = params[:name].split
    if customer.blank?
      generated_password = Devise.friendly_token(64)
      customer = Customer.create(first_name: name[0], last_name: name[1], phone: params[:phone], email: params[:email], password: generated_password, password_confirmation: generated_password)
    else
      customer.update(phone: params[:phone]) if customer.phone.blank?
      customer.update(first_name: name[0], last_name: name[1]) if customer.name.nil?
    end

    render json: customer.to_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:status, :price, :tax, :discount, :total_price, :transaction_id, :payment_method, :customer_id, :customer_name, :customer_phone, :customer_email, :vin_number, :make_model, :unit_number, :year, :odometer, :licence_number, invoice_products_attributes: %i[id product_id quantity price final_price _destroy], invoice_services_attributes: %i[id name price _destroy])
  end
end
