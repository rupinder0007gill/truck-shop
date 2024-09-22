# frozen_string_literal: true

# == Schema Information
#
# Table name: order_products
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  final_price_cents :bigint
#  price_cents       :bigint
#  quantity          :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_id          :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_order_products_on_deleted_at  (deleted_at)
#  index_order_products_on_order_id    (order_id)
#  index_order_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class OrderProduct < ApplicationRecord
  ##############################################################################
  ### Attributes ###############################################################
  monetize :price_cents
  monetize :final_price_cents, disable_validation: true

  ##############################################################################
  ### Constants ################################################################

  ##############################################################################
  ### Includes and Extensions ##################################################

  ##############################################################################
  ### Callbacks ################################################################

  ##############################################################################
  ### Associations #############################################################
  has_rich_text :description
  belongs_to :order
  belongs_to :product

  ##############################################################################
  ### Validations ##############################################################
  validates :quantity, presence: true, numericality: true

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
