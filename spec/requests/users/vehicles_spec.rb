# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/users/vehicles' do
  # This should return the minimal set of attributes required to create a valid
  # Users::Vehicle. As you add validations to Users::Vehicle, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Users::Vehicle.create! valid_attributes
      get users_vehicles_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      vehicle = Users::Vehicle.create! valid_attributes
      get users_vehicle_url(vehicle)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_users_vehicle_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      vehicle = Users::Vehicle.create! valid_attributes
      get edit_users_vehicle_url(vehicle)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Users::Vehicle' do
        expect do
          post users_vehicles_url, params: { users_vehicle: valid_attributes }
        end.to change(Users::Vehicle, :count).by(1)
      end

      it 'redirects to the created users_vehicle' do
        post users_vehicles_url, params: { users_vehicle: valid_attributes }
        expect(response).to redirect_to(users_vehicle_url(Users::Vehicle.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Users::Vehicle' do
        expect do
          post users_vehicles_url, params: { users_vehicle: invalid_attributes }
        end.not_to change(Users::Vehicle, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post users_vehicles_url, params: { users_vehicle: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested users_vehicle' do
        vehicle = Users::Vehicle.create! valid_attributes
        patch users_vehicle_url(vehicle), params: { users_vehicle: new_attributes }
        vehicle.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the users_vehicle' do
        vehicle = Users::Vehicle.create! valid_attributes
        patch users_vehicle_url(vehicle), params: { users_vehicle: new_attributes }
        vehicle.reload
        expect(response).to redirect_to(users_vehicle_url(vehicle))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        vehicle = Users::Vehicle.create! valid_attributes
        patch users_vehicle_url(vehicle), params: { users_vehicle: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested users_vehicle' do
      vehicle = Users::Vehicle.create! valid_attributes
      expect do
        delete users_vehicle_url(vehicle)
      end.to change(Users::Vehicle, :count).by(-1)
    end

    it 'redirects to the users_vehicles list' do
      vehicle = Users::Vehicle.create! valid_attributes
      delete users_vehicle_url(vehicle)
      expect(response).to redirect_to(users_vehicles_url)
    end
  end
end
