# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id                      :bigint           not null, primary key
#  archived_at             :datetime
#  deleted_at              :datetime
#  discount_cents          :bigint
#  invoice_number          :string
#  licence_number          :string
#  make_model              :string
#  odometer                :string
#  parts_rejection_comment :text
#  payment_method          :integer          default("cash"), not null
#  price_cents             :bigint
#  service_end_time        :datetime
#  service_estimted_time   :integer
#  service_start_time      :datetime
#  status                  :integer          default("pending"), not null
#  tax_cents               :bigint
#  total_price_cents       :bigint
#  unit_number             :string
#  vin_number              :string
#  year                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  customer_id             :bigint
#  transaction_id          :string
#  user_id                 :bigint
#  vehicle_id              :bigint
#
# Indexes
#
#  index_invoices_on_customer_id     (customer_id)
#  index_invoices_on_deleted_at      (deleted_at)
#  index_invoices_on_invoice_number  (invoice_number) UNIQUE
#  index_invoices_on_user_id         (user_id)
#  index_invoices_on_vehicle_id      (vehicle_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (vehicle_id => vehicles.id)
#
FactoryBot.define do
  factory :invoice do
  end
end
