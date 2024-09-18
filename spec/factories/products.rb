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
#  location            :text
#  name                :string
#  product_number      :string
#  selling_price_cents :bigint
#  slug                :string
#  total_stocks        :bigint           default(0)
#  used_stocks         :bigint           default(0)
#  warranty_period     :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_products_on_deleted_at  (deleted_at)
#
FactoryBot.define do
  factory :product do
    name { 'MyString' }
    description { 'MyText' }
    price_cents { 1 }
    slug { 'MyString' }
    selling_price_cents { 1 }
    user { nil }
  end
end
