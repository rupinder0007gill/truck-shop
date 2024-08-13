# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  archived_at         :datetime
#  available_stocks    :bigint           default(0)
#  base_price_cents    :bigint
#  core_price_cents    :bigint
#  deleted_at          :datetime
#  name                :string
#  product_number      :string
#  selling_price_cents :bigint
#  slug                :string
#  total_stocks        :bigint           default(0)
#  used_stocks         :bigint           default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_products_on_deleted_at  (deleted_at)
#
require 'rails_helper'

RSpec.describe Product do
  pending "add some examples to (or delete) #{__FILE__}"
end
