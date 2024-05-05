# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_services
#
#  id          :bigint           not null, primary key
#  archived_at :datetime
#  deleted_at  :datetime
#  name        :string
#  price_cents :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  invoice_id  :bigint
#
# Indexes
#
#  index_invoice_services_on_deleted_at  (deleted_at)
#  index_invoice_services_on_invoice_id  (invoice_id)
#
# Foreign Keys
#
#  fk_rails_...  (invoice_id => invoices.id)
#
require 'rails_helper'

RSpec.describe InvoiceService do
  pending "add some examples to (or delete) #{__FILE__}"
end
