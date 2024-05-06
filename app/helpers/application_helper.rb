# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info my-1'
    when 'success' then 'alert alert-success my-1'
    when 'error', 'alert' then 'alert alert-danger my-1'
    end
  end

  def website_name
    'Big Rigs Truck Centre'
  end

  def sortable_table_header(title, column, path_method, **)
    content_tag(:th, class: 'text-900 sort pe-1 align-middle text-center white-space-nowrap') do
      sortable_column(title, column, path_method)
    end
  end

  def sortable_column(title, column, path_method, **)
    direction = column.to_s == params[:sort].to_s && params[:direction] == 'asc' ? 'desc' : 'asc'

    query_params = request.query_parameters.merge(sort: column, direction:)

    path = send(path_method, query_params)
    link_to(path, class: 'flex items-center', data: { turbo_action: 'replace' }, **) do
      concat title
      concat sort_icon(column)
    end
  end

  def sort_icon(column)
    return unless params[:sort].to_s == column.to_s

    if params[:direction] == 'asc'
      svg_icon('M5 15l7-7 7 7')
    else
      svg_icon('M19 9l-7 7-7-7')
    end
  end

  def svg_icon(path_d)
    content_tag(:svg, xmlns: 'http://www.w3.org/2000/svg', class: 'ms-1 d-inline', style: 'width:15px; height: 15px;', fill: 'none', viewBox: '0 0 24 24', stroke: 'currentColor') do
      "<path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='#{path_d}'></path>".html_safe
    end
  end

  def format_price(number)
    if number >= 1_000_000
      "#{(number.to_f / 1_000_000).round(1)}M"
    elsif number >= 1_000
      "#{(number.to_f / 1_000).round(1)}K"
    else
      number.to_f
    end
  end

  def calculate_percentage_difference(last_price, current_price)
    last_price = 1 if last_price.to_i.zero?
    ((current_price.to_f - last_price.to_f) / last_price.to_f) * 100
  end

  def get_last_12_months
    # Get the current date
    current_date = Date.current

    # Initialize an empty array to store the list of months
    last_12_months = []

    # Loop through the last 12 months
    12.times do |i|
      # Subtract 'i' months from the current date to get the date of the i-th previous month
      month = current_date.months_ago(i)

      # Add the month to the list
      last_12_months << month.strftime('%B %Y')
    end
    last_12_months
  end

  def get_all_days_of_selected_month(first_day_of_month, last_day_of_month)
    # Create an array to store all the days of the month
    current_month_days = (first_day_of_month..last_day_of_month).to_a

    # Optionally, you can format the dates as strings if needed
    current_month_days.map(&:to_s)
  end

  def calculate_percentage_from_two_numbers(whole, part)
    # Ensure that the denominator is not zero to avoid division by zero error
    return 1 if whole.zero?

    # Calculate the percentage
    percentage = (part.to_f / whole) * 100

    # Round the percentage to two decimal places
    percentage.round(2)
  end
end
