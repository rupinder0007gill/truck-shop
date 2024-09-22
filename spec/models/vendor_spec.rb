# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe Vendor do
  pending "add some examples to (or delete) #{__FILE__}"
end
