# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_deleted_at  (deleted_at)
#
FactoryBot.define do
  factory :role do
    name { 'MyString' }
    deleted_at { '2024-04-09 11:11:04' }
  end
end
