# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/vehicles/edit' do
  let(:users_vehicle) do
    Users::Vehicle.create!
  end

  before do
    assign(:users_vehicle, users_vehicle)
  end

  it 'renders the edit users_vehicle form' do
    render

    assert_select 'form[action=?][method=?]', users_vehicle_path(users_vehicle), 'post' do
    end
  end
end
