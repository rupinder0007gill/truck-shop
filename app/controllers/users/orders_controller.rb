# frozen_string_literal: true

class Users::OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy deliver]

  # GET /users/orders or /users/orders.json
  def index
    @search_url = users_orders_path
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction].presence_in(%w[asc desc]) || 'desc'

    @orders = if params[:query].present?
                Order.joins(:user).where('lower(users.first_name) LIKE ? OR lower(users.last_name) LIKE ?', "%#{params[:query].downcase}%", "%#{params[:query].downcase}%")
              else
                Order.includes(:user).all
              end
    @pagy, @orders = pagy(@orders.order("#{sort_column} #{sort_direction}"), items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream # Respond to Turbo Stream requests
    end
  end

  # GET /users/orders/1 or /users/orders/1.json
  def show; end

  # GET /users/orders/new
  def new
    @order = current_user.orders.new(price: 0, tax: 0, discount: 0, total_price: 0)
  end

  # GET /users/orders/1/edit
  def edit; end

  # POST /users/orders or /users/orders.json
  def create
    @order = current_user.orders.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to users_orders_url, notice: 'Order was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/orders/1 or /users/orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to users_orders_url, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/orders/1 or /users/orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to users_orders_url, notice: 'Order was successfully destroyed.' }
    end
  end

  def deliver
    redirect_to users_orders_url, alert: 'You are not authorized to perform this action, please ask to admin to update status' and return if current_user.role.name != 'Admin'

    @order.update(status: :delivered)

    respond_to do |format|
      format.html { redirect_to users_orders_url, notice: 'Order was successfully delivered.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:status, :price, :tax, :discount, :total_price, :description, :file, :transaction_id, :payment_method, order_products_attributes: %i[id product_id quantity price final_price _destroy])
  end
end
