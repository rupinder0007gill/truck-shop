# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                  :bigint           not null, primary key
#  css_class           :string           default("alert-light")
#  deleted_at          :datetime
#  is_read_by_receiver :boolean          default(FALSE)
#  is_read_by_sender   :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_id         :bigint
#  to_user_id          :bigint
#  user_id             :bigint
#
# Indexes
#
#  index_notifications_on_customer_id  (customer_id)
#  index_notifications_on_deleted_at   (deleted_at)
#  index_notifications_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :notification do
    client { nil }
    to_user_id { 1 }
    from_user_id { 1 }
    is_read_by_sender { false }
    is_read_by_receiver { false }
  end
end
