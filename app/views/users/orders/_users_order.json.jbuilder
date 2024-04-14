# frozen_string_literal: true

json.extract! users_order, :id, :created_at, :updated_at
json.url users_order_url(users_order, format: :json)
