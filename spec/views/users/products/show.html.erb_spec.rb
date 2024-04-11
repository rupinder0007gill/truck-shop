# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/products/show' do
  before do
    assign(:users_product, Users::Product.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
