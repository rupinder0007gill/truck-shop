# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    parsed_date = if params[:month].present?
                    Date.parse(params[:month])
                  else
                    Date.current
                  end
    # Get the start date of the month
    @first_day_of_month = parsed_date.beginning_of_month
    # Get the last day of the current month
    @last_day_of_month = parsed_date.end_of_month
  end

  def analytics; end
  def crm; end
  def ecommerce; end
  def lms; end
  def management; end
  def saas; end
end
