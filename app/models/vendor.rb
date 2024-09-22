# == Schema Information
#
# Table name: vendors
#
#  id          :bigint           not null, primary key
#  archived_at :datetime
#  deleted_at  :datetime
#  name        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_vendors_on_deleted_at  (deleted_at)
#
class Vendor < ApplicationRecord
  validates :name, presence: true
end