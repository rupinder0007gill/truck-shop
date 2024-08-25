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

  def search_vehicle
    vehicles = Vehicle.search_for(params[:vin_search])
    render json: vehicles.to_json
  end

  def find_or_create_customer
    customer = Customer.find_by(email: params[:email])
    if customer.blank?
      generated_password = Devise.friendly_token(64)
      customer = Customer.new(first_name: params[:first_name], last_name: params[:last_name], phone: params[:phone], email: params[:email], password: generated_password, password_confirmation: generated_password, secondary_email: params[:secondary_email], company_name: params[:company_name], address: params[:address], card_number: params[:card_number], expiry: params[:expiry], card_name: params[:card_name], cvv: params[:cvv])
    else
      customer.phone = params[:phone] if customer.phone.blank?
      customer.last_name = params[:last_name] if customer.last_name.blank?
      customer.secondary_email = params[:secondary_email] if customer.secondary_email.blank?
      customer.company_name = params[:company_name] if customer.company_name.blank?
      customer.address = params[:address] if customer.address.blank?
      customer.card_number = params[:card_number] if customer.card_number.blank?
      customer.expiry = params[:expiry] if customer.expiry.blank?
      customer.card_name = params[:card_name] if customer.card_name.blank?
      customer.cvv = params[:cvv] if customer.cvv.blank?
    end

    if customer.save
      render json: customer.to_json
    else
      render json: customer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def find_or_create_vehicle
    vehicle = Vehicle.find_by(vin: params[:vin])
    if vehicle.blank?
      vehicle = Vehicle.new(vin: params[:vin], make_model: params[:make_model], unit_number: params[:unit_number], year: params[:year], licence_number: params[:licence_number], po_number: params[:po_number])
    else
      vehicle.make_model = params[:make_model] if vehicle.make_model.blank?
      vehicle.unit_number = params[:unit_number] if vehicle.unit_number.blank?
      vehicle.year = params[:year] if vehicle.year.blank?
      vehicle.licence_number = params[:licence_number] if vehicle.licence_number.blank?
      vehicle.po_number = params[:po_number] if vehicle.po_number.blank?
    end

    if vehicle.save
      render json: vehicle.to_json
    else
      render json: vehicle.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:status, :price, :tax, :discount, :total_price, :transaction_id, :payment_method, :customer_id, :customer_name, :customer_phone, :customer_email, :vehicle_id, :odometer, invoice_items_attributes: %i[id is_core_product invoice_type product_id description qty price final_price _destroy])
  end
end
