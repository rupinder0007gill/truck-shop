# frozen_string_literal: true

json.extract! users_product, :id, :created_at, :updated_at
json.url users_product_url(users_product, format: :json)
