# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info my-1'
    when 'success' then 'alert alert-success my-1'
    when 'error' then 'alert alert-danger my-1'
    when 'alert' then 'alert alert-warning my-1'
    end
  end

  def website_name
    'Big Rigs Truck Centre'
  end
end
