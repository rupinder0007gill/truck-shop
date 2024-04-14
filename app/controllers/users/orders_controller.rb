# frozen_string_literal: true

class Users::OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /users/orders or /users/orders.json
  def index
    @orders = Order.all
  end

  # GET /users/orders/1 or /users/orders/1.json
  def show; end

  # GET /users/orders/new
  def new
    @order = current_user.orders.new
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:status, :price, :tax, :discount, :total_price, :description, :file, order_products_attributes: %i[id product_id quantity price final_price _destroy])
  end
end
