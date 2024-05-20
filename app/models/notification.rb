# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                  :bigint           not null, primary key
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
class Notification < ApplicationRecord
  ##############################################################################
  ### Attributes ###############################################################

  ##############################################################################
  ### Constants ################################################################

  ##############################################################################
  ### Includes and Extensions ##################################################

  ##############################################################################
  ### Callbacks ################################################################

  ##############################################################################
  ### Associations #############################################################
  has_rich_text :notification_body
  belongs_to :user
  belongs_to :admin_user, class_name: 'User', foreign_key: 'to_user_id', optional: true
  belongs_to :customer, optional: true

  ##############################################################################
  ### Validations ##############################################################

  ##############################################################################
  ### Scopes ###################################################################

  ##############################################################################
  ### Other ####################################################################

  ##############################################################################
  ### Class Methods ############################################################

  ##############################################################################
  ### Instance Methods #########################################################

  #########

  # protected

  #########

  #######

  # private

  #######
end
