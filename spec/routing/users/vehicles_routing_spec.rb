# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::VehiclesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/vehicles').to route_to('users/vehicles#index')
    end

    it 'routes to #new' do
      expect(get: '/users/vehicles/new').to route_to('users/vehicles#new')
    end

    it 'routes to #show' do
      expect(get: '/users/vehicles/1').to route_to('users/vehicles#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/users/vehicles/1/edit').to route_to('users/vehicles#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/vehicles').to route_to('users/vehicles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/vehicles/1').to route_to('users/vehicles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/vehicles/1').to route_to('users/vehicles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/vehicles/1').to route_to('users/vehicles#destroy', id: '1')
    end
  end
end
