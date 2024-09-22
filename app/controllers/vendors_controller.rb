# frozen_string_literal: true

class VendorsController < ApplicationController
  before_action :set_vendor, only: %i[show edit update destroy]

  def index
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction].presence_in(%w[asc desc]) || 'desc'
    @vendors = if params[:query].present?
                 Vendor.search_for(params[:query])
               else
                 Vendor.all
               end
    @pagy, @vendors = pagy(@vendors.order("#{sort_column} #{sort_direction}"), items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream # Respond to Turbo Stream requests
    end
  end

  def show; end

  def new
    @vendor = Vendor.new
  end

  def edit; end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to vendors_url, notice: 'Vendor created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @vendor.update(vendor_params)
      redirect_to vendors_url, notice: 'vendor updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/products/1 or /users/products/1.json
  def destroy
    @vendor.destroy!
    flash.now[:alert] = 'vendor destroyed successfully.'

    respond_to do |format|
      format.html { redirect_to vendors_url, alert: 'vendor destroyed successfully.' }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@vendor),
          turbo_stream.update('flash', partial: 'layouts/partials/flash')
        ]
      end
    end
  end

  private

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vendor_params
    params.require(:vendor).permit(:name)
  end
end
