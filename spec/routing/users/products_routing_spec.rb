# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ProductsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/products').to route_to('users/products#index')
    end

    it 'routes to #new' do
      expect(get: '/users/products/new').to route_to('users/products#new')
    end

    it 'routes to #show' do
      expect(get: '/users/products/1').to route_to('users/products#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/users/products/1/edit').to route_to('users/products#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/products').to route_to('users/products#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/products/1').to route_to('users/products#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/products/1').to route_to('users/products#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/products/1').to route_to('users/products#destroy', id: '1')
    end
  end
end
