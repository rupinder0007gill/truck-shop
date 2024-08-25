# == Schema Information
#
# Table name: invoice_items
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  final_price_cents :bigint
#  invoice_type      :integer
#  is_core_product   :boolean          default(FALSE)
#  price_cents       :bigint
#  qty               :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  invoice_id        :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_invoice_items_on_deleted_at  (deleted_at)
#  index_invoice_items_on_invoice_id  (invoice_id)
#  index_invoice_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (invoice_id => invoices.id)
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :invoice_item do
    invoice { nil }
    product { nil }
    qty { 1 }
    price_cents { 1 }
    final_price_cents { 1 }
  end
end
