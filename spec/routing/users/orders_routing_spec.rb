# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OrdersController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/orders').to route_to('users/orders#index')
    end

    it 'routes to #new' do
      expect(get: '/users/orders/new').to route_to('users/orders#new')
    end

    it 'routes to #show' do
      expect(get: '/users/orders/1').to route_to('users/orders#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/users/orders/1/edit').to route_to('users/orders#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/orders').to route_to('users/orders#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/orders/1').to route_to('users/orders#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/orders/1').to route_to('users/orders#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/orders/1').to route_to('users/orders#destroy', id: '1')
    end
  end
end
