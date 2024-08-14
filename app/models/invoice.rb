# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id                    :bigint           not null, primary key
#  archived_at           :datetime
#  deleted_at            :datetime
#  discount_cents        :bigint
#  licence_number        :string
#  make_model            :string
#  odometer              :string
#  payment_method        :integer          default("cash"), not null
#  price_cents           :bigint
#  service_end_time      :datetime
#  service_estimted_time :integer
#  service_start_time    :datetime
#  status                :integer          default("pending"), not null
#  tax_cents             :bigint
#  total_price_cents     :bigint
#  unit_number           :string
#  vin_number            :string
#  year                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  customer_id           :bigint
#  transaction_id        :string
#  user_id               :bigint
#  vehicle_id            :bigint
#
# Indexes
#
#  index_invoices_on_customer_id  (customer_id)
#  index_invoices_on_deleted_at   (deleted_at)
#  index_invoices_on_user_id      (user_id)
#  index_invoices_on_vehicle_id   (vehicle_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (vehicle_id => vehicles.id)
#
class Invoice < ApplicationRecord
  attr_accessor :customer_name, :customer_phone, :customer_email, :current_admin

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
  before_save :invoice_paid_notification
  before_create :set_service_start_time
  after_create :reduce_products_stocks, :set_invoice_id, :create_notifications
  after_update :set_invoice_id
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
  belongs_to :customer, optional: true
  belongs_to :vehicle, optional: true

  ##############################################################################
  ### Validations ##############################################################
  validate :check_available_stock, on: :create

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

  def set_service_start_time
    self.service_start_time = Time.zone.now
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

  def set_invoice_id
    return if customer_id.present?

    customer = Customer.find_by(email: customer_email)
    if customer.blank?
      generated_password = Devise.friendly_token(64)
      name = customer_name.split
      customer = Customer.create(first_name: name[0], last_name: name[1], phone: customer_phone, email: customer_email, password: generated_password, password_confirmation: generated_password)
    end
    update(customer_id: customer.id)
  end

  def invoice_paid_notification
    return unless status_changed? && status == 'paid'

    # send notification
    return unless current_admin != user

    invoice_url = Rails.application.routes.url_helpers.users_invoice_url(id)
    current_admin.notifications.create(to_user_id: user.id, css_class: 'alert-success', notification_body: "#{current_admin.name} marked invoice to paid. please check the <a href='#{invoice_url}'>invoice</a>")
  end

  def create_notifications
    User.joins(:role).where('lower(roles.name) = ?', 'admin').find_each do |admin_user|
      invoice_url = Rails.application.routes.url_helpers.users_invoice_url(id)
      user.notifications.create(to_user_id: admin_user.id, css_class: 'alert-info', notification_body: "#{user.name} open a service for #{customer.name}. please check the <a href='#{invoice_url}'>invoice</a>")
    end
  end
end
