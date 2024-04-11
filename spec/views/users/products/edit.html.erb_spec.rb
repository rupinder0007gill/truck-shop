# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/products/edit' do
  let(:users_product) do
    Users::Product.create!
  end

  before do
    assign(:users_product, users_product)
  end

  it 'renders the edit users_product form' do
    render

    assert_select 'form[action=?][method=?]', users_product_path(users_product), 'post' do
    end
  end
end
