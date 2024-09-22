# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/orders/new' do
  before do
    assign(:users_order, Users::Order.new)
  end

  it 'renders new users_order form' do
    render

    assert_select 'form[action=?][method=?]', users_orders_path, 'post' do
    end
  end
end
