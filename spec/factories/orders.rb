# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  discount_cents    :bigint
#  eta               :datetime
#  payment_method    :integer          default("cash"), not null
#  price_cents       :bigint
#  status            :integer          default("placed"), not null
#  tax_cents         :bigint
#  total_price_cents :bigint
#  trackingurl       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  transaction_id    :string
#  user_id           :bigint
#
# Indexes
#
#  index_orders_on_deleted_at  (deleted_at)
#  index_orders_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :order do
  end
end
