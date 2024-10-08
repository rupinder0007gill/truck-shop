# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_items
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  description       :text
#  final_price_cents :bigint
#  invoice_type      :integer
#  is_core_product   :boolean          default(FALSE)
#  price_cents       :bigint
#  qty               :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  core_product_id   :bigint
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
require 'rails_helper'

RSpec.describe InvoiceItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
