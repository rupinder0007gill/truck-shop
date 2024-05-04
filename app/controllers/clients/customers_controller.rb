# frozen_string_literal: true

class Clients::CustomersController < ApplicationController
  before_action :set_customer, only: %i[edit update destroy show]

  def index
    @search_url = clients_customers_path
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction].presence_in(%w[asc desc]) || 'desc'

    @customers = if params[:query].present?
                   Customer.search_for(params[:query])
                 else
                   Customer.all
                 end
    @pagy, @customers = pagy(@customers.order("#{sort_column} #{sort_direction}"), items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream # Respond to Turbo Stream requests
    end
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def edit; end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save!
      redirect_to clients_customer_path(@customer), notice: 'Customer was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @customer.update(customer_params)
    if @customer.save!
      redirect_to clients_customer_path(@customer), notice: 'Customer was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    redirect_to clients_customer_path, notice: 'Customer was successfully deleted.'
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :address)
  end
end
