# frozen_string_literal: true

# == Schema Information
#
# Table name: vehicles
#
#  id             :bigint           not null, primary key
#  archived_at    :datetime
#  deleted_at     :datetime
#  licence_number :string
#  make_model     :string
#  po_number      :string
#  unit_number    :string
#  vin            :string
#  year           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :bigint
#
# Indexes
#
#  index_vehicles_on_customer_id  (customer_id)
#  index_vehicles_on_deleted_at   (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
require 'rails_helper'

RSpec.describe Vehicle do
  pending "add some examples to (or delete) #{__FILE__}"
end
