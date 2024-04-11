# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/products/index' do
  before do
    assign(:users_products, [
             Users::Product.create!,
             Users::Product.create!
           ])
  end

  it 'renders a list of users/products' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
