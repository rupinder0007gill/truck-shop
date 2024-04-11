# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                            :bigint           not null, primary key
#  archived_at                   :datetime
#  available_stocks              :bigint           default(0)
#  deleted_at                    :datetime
#  discount_percentage           :integer
#  manufacturar_name             :string
#  name                          :string
#  price_cents                   :bigint
#  product_identification_number :string
#  product_summary               :string
#  release_date                  :datetime
#  selling_price_cents           :bigint
#  slug                          :string
#  status                        :integer          default("draft"), not null
#  total_stocks                  :bigint           default(0)
#  used_stocks                   :bigint           default(0)
#  warranty_length               :string
#  warranty_policy               :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  user_id                       :bigint
#
# Indexes
#
#  index_products_on_deleted_at  (deleted_at)
#  index_products_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
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
