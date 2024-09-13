# frozen_string_literal: true

class Users::SettingsController < ApplicationController
  load_and_authorize_resource

  def index
    @setting = Setting.last || Setting.new
  end

  def create
    @setting = Setting.last || Setting.new
    @setting.tax_name = user_params[:tax_name]
    @setting.hourly_rate = user_params[:hourly_rate]
    @setting.tax_percentage = user_params[:tax_percentage]
    if @setting.save
      redirect_to users_settings_path, notice: 'Settings updated successfully.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:setting).permit(:tax_name, :tax_percentage, :hourly_rate)
  end
end
