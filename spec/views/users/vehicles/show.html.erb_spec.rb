# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/vehicles/show' do
  before do
    assign(:users_vehicle, Users::Vehicle.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
