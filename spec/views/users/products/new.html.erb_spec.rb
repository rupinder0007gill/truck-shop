# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/products/new' do
  before do
    assign(:users_product, Users::Product.new)
  end

  it 'renders new users_product form' do
    render

    assert_select 'form[action=?][method=?]', users_products_path, 'post' do
    end
  end
end
