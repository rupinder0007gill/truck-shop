# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = 'Access denied. You are not authorized to access the requested page.'
    redirect_back(fallback_location: root_path)
    # redirect_to root_path
  end
end
