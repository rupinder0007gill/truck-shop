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
FactoryBot.define do
  factory :vehicle do
    vin { 'MyString' }
    make_model { 'MyString' }
    unit_number { 'MyString' }
    year { 1 }
    licence_number { 'MyString' }
    po_number { 'MyString' }
    customer { nil }
  end
end
