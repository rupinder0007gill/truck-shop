# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  discount_cents    :bigint
#  payment_method    :integer          default("cash"), not null
#  price_cents       :bigint
#  status            :integer          default("pending"), not null
#  tax_cents         :bigint
#  total_price_cents :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  transaction_id    :string
#  user_id           :bigint
#
# Indexes
#
#  index_invoices_on_deleted_at  (deleted_at)
#  index_invoices_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :invoice do
  end
end
