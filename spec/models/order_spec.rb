# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  discount_cents    :bigint
#  price_cents       :bigint
#  status            :integer
#  tax_cents         :bigint
#  total_price_cents :bigint
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
require 'rails_helper'

RSpec.describe Order do
  pending "add some examples to (or delete) #{__FILE__}"
end
