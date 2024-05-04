# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  discount_cents    :bigint
#  payment_method    :integer          default("cash"), not null
#  price_cents       :bigint
#  status            :integer          default("pending"), not null
#  tax_cents         :bigint
#  total_price_cents :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  transaction_id    :string
#  user_id           :bigint
#
# Indexes
#
#  index_invoices_on_deleted_at  (deleted_at)
#  index_invoices_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Invoice < ApplicationRecord
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
  after_save :update_products_stocks

  ##############################################################################
  ### Associations #############################################################
  has_one_attached :file
  has_rich_text :description
  has_many :invoice_products, dependent: :destroy
  has_many :products, through: :invoice_products
  has_many :invoice_services, dependent: :destroy
  has_many :services, through: :invoice_services
  accepts_nested_attributes_for :invoice_products, allow_destroy: true, reject_if: proc { |attributes|
                                                                                     attributes['product_id'].blank?
                                                                                   }
  accepts_nested_attributes_for :invoice_services, allow_destroy: true, reject_if: proc { |attributes|
                                                                                     attributes['service_id'].blank?
                                                                                   }
  belongs_to :user

  ##############################################################################
  ### Validations ##############################################################

  ##############################################################################
  ### Scopes ###################################################################
  scope :paid_invoices, -> { where(status: 1) }
  scope :pending_invoices, -> { where(status: 0) }

  ##############################################################################
  ### Other ####################################################################
  enum status: {
    pending: 0,
    paid: 1
  }

  enum payment_method: {
    cash: 0,
    card: 1,
    online: 2
  }

  ##############################################################################
  ### Class Methods ############################################################

  ##############################################################################
  ### Instance Methods #########################################################

  #########

  # protected

  #########

  #######

  private

  #######
  def update_products_stocks
    return unless status_changed? && status == 'pending'

    invoice_products.each do |invoice_product|
      product = invoice_product.product
      product.update(total_stocks: (product.total_stocks + invoice_product.quantity), available_stocks: (product.available_stocks + invoice_product.quantity))
    end
  end
end
