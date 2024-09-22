# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/orders/show' do
  before do
    assign(:users_order, Users::Order.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
