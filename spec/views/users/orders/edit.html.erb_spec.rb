# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/orders/edit' do
  let(:users_order) do
    Users::Order.create!
  end

  before do
    assign(:users_order, users_order)
  end

  it 'renders the edit users_order form' do
    render

    assert_select 'form[action=?][method=?]', users_order_path(users_order), 'post' do
    end
  end
end
