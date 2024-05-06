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

    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week
    last_week_start_date = (Date.today - 7.days).beginning_of_week
    last_week_end_date = (Date.today - 7.days).end_of_week

    @last_week_invoices_total_prices = Invoice.where(created_at: last_week_start_date..last_week_end_date).sum(:total_price_cents)
    @current_week_invoices = Invoice.group_by_day(:created_at, range: start_date.beginning_of_day..end_date.end_of_day).sum(:total_price_cents)

    @last_week_orders_total_prices = Order.where(created_at: last_week_start_date..last_week_end_date).sum(:total_price_cents)
    @current_week_orders = Order.group_by_day(:created_at, range: start_date.beginning_of_day..end_date.end_of_day).sum(:total_price_cents)

    @best_technician_invoices = Invoice.where(created_at: start_date.beginning_of_day..end_date.end_of_day).group(:user_id).sum(:total_price_cents)
    @available_techinician = User.where(role_id: 3).where.not(id: @best_technician_invoices.keys)
  end

  def analytics; end
  def crm; end
  def ecommerce; end
  def lms; end
  def management; end
  def saas; end
end
