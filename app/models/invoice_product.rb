# == Schema Information
#
# Table name: invoice_products
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  final_price_cents :bigint
#  price_cents       :bigint
#  quantity          :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  invoice_id        :bigint
#  product_id        :bigint
#
# Indexes
#
#  index_invoice_products_on_deleted_at  (deleted_at)
#  index_invoice_products_on_invoice_id  (invoice_id)
#  index_invoice_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (invoice_id => invoices.id)
#  fk_rails_...  (product_id => products.id)
#
class InvoiceProduct < ApplicationRecord
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
  belongs_to :invoice
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
