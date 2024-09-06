# frozen_string_literal: true

class Users::VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[edit update destroy]
  load_and_authorize_resource

  # GET /users/vehicles or /users/vehicles.json
  def index
    @search_url = users_vehicles_path
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction].presence_in(%w[asc desc]) || 'desc'

    @vehicles = if params[:query].present?
                  Vehicle.search_for(params[:query])
                else
                  Vehicle.all
                end
    @pagy, @vehicles = pagy(@vehicles.order("#{sort_column} #{sort_direction}"), items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream # Respond to Turbo Stream requests
    end
  end

  # GET /users/vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /users/vehicles/1/edit
  def edit; end

  # POST /users/vehicles or /users/vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to users_vehicles_path, notice: 'Vehicle was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/vehicles/1 or /users/vehicles/1.json
  def update
    if @vehicle.update(vehicle_params)
      redirect_to users_vehicles_path, notice: 'Vehicle was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/vehicles/1 or /users/vehicles/1.json
  def destroy
    @vehicle.destroy!
    flash.now[:alert] = 'Vehicle was successfully destroyed.'

    respond_to do |format|
      format.html { redirect_to users_vehicles_url, alert: 'Vehicle was successfully destroyed.' }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@vehicle),
          turbo_stream.update('flash', partial: 'layouts/partials/flash')
        ]
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vehicle_params
    params.require(:vehicle).permit(:licence_number, :make_model, :po_number, :unit_number, :vin, :year, :customer_id)
  end
end
