# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/orders/index' do
  before do
    assign(:users_orders, [
             Users::Order.create!,
             Users::Order.create!
           ])
  end

  it 'renders a list of users/orders' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
