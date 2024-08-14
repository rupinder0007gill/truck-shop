# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/vehicles/index' do
  before do
    assign(:users_vehicles, [
             Users::Vehicle.create!,
             Users::Vehicle.create!
           ])
  end

  it 'renders a list of users/vehicles' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
