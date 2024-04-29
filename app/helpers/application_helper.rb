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
    content_tag(:th, class: "text-900 sort pe-1 align-middle white-space-nowrap") do
      sortable_column(title, column, path_method)
    end
  end

  def sortable_column(title, column, path_method, **)
    direction = (column.to_s == params[:sort].to_s && params[:direction] == "asc") ? "desc" : "asc"

    query_params = request.query_parameters.merge(sort: column, direction: direction)

    path = send(path_method, query_params)
    link_to(path, class: "flex items-center", data: { turbo_action: 'replace' }, **) do
      concat title
      concat sort_icon(column)
    end
  end

  def sort_icon(column)
    return unless params[:sort].to_s == column.to_s

    if params[:direction] == "asc"
      svg_icon("M5 15l7-7 7 7")
    else
      svg_icon("M19 9l-7 7-7-7")
    end
  end

  def svg_icon(path_d)
    content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", class: "ms-1 d-inline", style: "width:15px; height: 15px;", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor") do
      "<path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='#{path_d}'></path>".html_safe
    end
  end
end
