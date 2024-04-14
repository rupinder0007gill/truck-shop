# frozen_string_literal: true

json.array! @users_orders, partial: 'users_orders/users_order', as: :users_order
