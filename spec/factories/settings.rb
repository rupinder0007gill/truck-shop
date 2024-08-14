# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id             :bigint           not null, primary key
#  archived_at    :datetime
#  deleted_at     :datetime
#  hourly_rate    :integer
#  tax_name       :string
#  tax_percentage :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_settings_on_deleted_at  (deleted_at)
#
FactoryBot.define do
  factory :setting do
    hourly_rate { 1 }
    tax_percentage { 1.5 }
    tax_name { 'MyString' }
  end
end
