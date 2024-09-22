# frozen_string_literal: true

class Users::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /users/products or /users/products.json
  def index
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction].presence_in(%w[asc desc]) || 'desc'

    @products = if params[:query].present?
                  Product.search_for(params[:query])
                else
                  Product.all
                end
    @pagy, @products = pagy(@products.order("#{sort_column} #{sort_direction}"), items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream # Respond to Turbo Stream requests
    end
  end

  # GET /users/products/1
  def show; end

  # GET /users/products/new
  def new
    @product = Product.new
  end

  # GET /users/products/1/edit
  def edit; end

  # POST /users/products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to users_products_url, notice: 'Product created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/products/1
  def update
    if @product.update(product_params)
      redirect_to users_products_url, notice: 'Product updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/products/1 or /users/products/1.json
  def destroy
    @product.destroy!
    flash.now[:alert] = 'Product destroyed successfully.'

    respond_to do |format|
      format.html { redirect_to users_products_url, alert: 'Product destroyed successfully.' }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@product),
          turbo_stream.update('flash', partial: 'layouts/partials/flash')
        ]
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:product_number, :name, :add_stock, :location, :warranty_period, :vendor_id, :description, :base_price, :selling_price, :core_price)
  end
end
