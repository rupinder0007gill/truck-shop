class Clients::CustomersController < ApplicationController
  before_action :set_customer, only: %i[edit update destroy show]


  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def edit; end

  def show
  end

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
