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
class Order < ApplicationRecord
  ##############################################################################
  ### Attributes ###############################################################
  monetize :price_cents
  monetize :tax_cents, disable_validation: true
  monetize :discount_cents, disable_validation: true
  monetize :total_price_cents, disable_validation: true

  ##############################################################################
  ### Constants ################################################################

  ##############################################################################
  ### Includes and Extensions ##################################################

  ##############################################################################
  ### Callbacks ################################################################

  ##############################################################################
  ### Associations #############################################################
  has_one_attached :file
  has_rich_text :description
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true, reject_if: :all_blank
  belongs_to :user

  ##############################################################################
  ### Validations ##############################################################

  ##############################################################################
  ### Scopes ###################################################################
  scope :delivered_orders, -> { where(status: 1) }
  scope :placed_orders, -> { where(status: 0) }

  ##############################################################################
  ### Other ####################################################################
  enum status: {
    placed: 0,
    delivered: 1
  }

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
