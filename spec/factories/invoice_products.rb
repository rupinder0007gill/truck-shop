# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_products
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  final_price_cents :bigint
#  price_cents       :bigint
#  quantity          :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  invoice_id        :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_invoice_products_on_deleted_at  (deleted_at)
#  index_invoice_products_on_invoice_id  (invoice_id)
#  index_invoice_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (invoice_id => invoices.id)
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :invoice_product do
  end
end
