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
  after_create :reduce_products_stocks
  before_destroy :add_products_stocks

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
                                                                                     attributes['name'].blank?
                                                                                   }
  belongs_to :user

  ##############################################################################
  ### Validations ##############################################################
  validate :check_available_stock

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
  def check_available_stock
    invoice_products.each do |invoice_product|
      product = invoice_product.product
      errors.add(:base, "We have only #{product.available_stocks} #{product.name} available, we are out of stock.") if invoice_product.quantity > product.available_stocks
    end
  end

  def reduce_products_stocks
    invoice_products.each do |invoice_product|
      product = invoice_product.product
      product.update(available_stocks: (product.available_stocks - invoice_product.quantity))
    end
  end

  def add_products_stocks
    return if status == 'paid'

    invoice_products.each do |invoice_product|
      product = invoice_product.product
      product.update(available_stocks: (product.available_stocks + invoice_product.quantity))
    end
  end
end
