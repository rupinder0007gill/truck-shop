# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/vehicles/new' do
  before do
    assign(:users_vehicle, Users::Vehicle.new)
  end

  it 'renders new users_vehicle form' do
    render

    assert_select 'form[action=?][method=?]', users_vehicles_path, 'post' do
    end
  end
end
