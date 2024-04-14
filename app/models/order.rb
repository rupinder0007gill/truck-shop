# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  archived_at       :datetime
#  deleted_at        :datetime
#  discount_cents    :bigint
#  payment_method    :integer          default("cash"), not null
#  price_cents       :bigint
#  status            :integer          default("placed"), not null
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
  before_save :update_products_stocks

  ##############################################################################
  ### Associations #############################################################
  has_one_attached :file
  has_rich_text :description
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true, reject_if: proc { |attributes|
                                                                                   attributes['product_id'].blank?
                                                                                 }
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
    return unless status_changed? && status == 'delivered'

    order_products.each do |order_product|
      product = order_product.product
      product.update(total_stocks: (product.total_stocks + order_product.quantity), available_stocks: (product.available_stocks + order_product.quantity))
    end
  end
end
