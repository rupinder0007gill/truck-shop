# frozen_string_literal: true

class Users::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /users/products or /users/products.json
  def index
    @products = Product.all
  end

  # GET /users/products/1
  def show; end

  # GET /users/products/new
  def new
    @product = current_user.products.new(discount_percentage: 0)
  end

  # GET /users/products/1/edit
  def edit; end

  # POST /users/products
  def create
    @product = current_user.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to users_products_url, notice: 'Product was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to users_products_url, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/products/1 or /users/products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to users_products_url, alert: 'Product was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :manufacturar_name, :product_identification_number, :product_summary, :description, :release_date, :warranty_length, :warranty_policy, :discount_percentage, :price, :selling_price, :selling_price_cents, :status, :add_stock, images: [])
  end
end
