# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_items
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  description       :text
#  final_price_cents :bigint
#  invoice_type      :integer
#  is_core_product   :boolean          default(FALSE)
#  price_cents       :bigint
#  qty               :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  core_product_id   :bigint
#  invoice_id        :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_invoice_items_on_deleted_at  (deleted_at)
#  index_invoice_items_on_invoice_id  (invoice_id)
#  index_invoice_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (invoice_id => invoices.id)
#  fk_rails_...  (product_id => products.id)
#
class InvoiceItem < ApplicationRecord
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
  belongs_to :invoice
  # Normal product relationship
  belongs_to :product, class_name: 'Product', optional: true
  # Core product relationship
  belongs_to :core_product, class_name: 'Product', optional: true

  ##############################################################################
  ### Validations ##############################################################
  validates :qty, presence: true, numericality: true

  ##############################################################################
  ### Scopes ###################################################################

  ##############################################################################
  ### Other ####################################################################
  enum invoice_type: {
    product: 0,
    labour: 1,
    core_product: 2
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
