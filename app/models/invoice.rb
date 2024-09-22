# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id                      :bigint           not null, primary key
#  archived_at             :datetime
#  deleted_at              :datetime
#  discount_cents          :bigint
#  invoice_number          :string
#  licence_number          :string
#  make_model              :string
#  odometer                :string
#  parts_rejection_comment :text
#  payment_method          :integer          default("cash"), not null
#  price_cents             :bigint
#  service_end_time        :datetime
#  service_estimted_time   :integer
#  service_start_time      :datetime
#  status                  :integer          default("pending"), not null
#  tax_cents               :bigint
#  total_price_cents       :bigint
#  unit_number             :string
#  vin_number              :string
#  year                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  customer_id             :bigint
#  transaction_id          :string
#  user_id                 :bigint
#  vehicle_id              :bigint
#
# Indexes
#
#  index_invoices_on_customer_id     (customer_id)
#  index_invoices_on_deleted_at      (deleted_at)
#  index_invoices_on_invoice_number  (invoice_number) UNIQUE
#  index_invoices_on_user_id         (user_id)
#  index_invoices_on_vehicle_id      (vehicle_id)
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
  before_save :invoice_status_change_notification
  before_create :set_service_start_time
  before_create :generate_invoice_number
  after_create :set_invoice_id, :create_notifications, :set_customer_id_to_vehicles
  after_update :set_invoice_id

  ##############################################################################
  ### Associations #############################################################
  has_one_attached :file
  has_rich_text :description
  has_many :products, through: :invoice_items
  has_many :invoice_items, dependent: :destroy
  accepts_nested_attributes_for :invoice_items, allow_destroy: true, reject_if: proc { |attributes|
                                                                                  attributes['qty'] == '0'
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
    parts_approved: 1,
    parts_rejected: 2,
    completed: 3,
    approved: 4,
    paid: 5
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
    invoice_items.each do |invoice_item|
      next if invoice_item.product.blank?

      product = invoice_item.product
      errors.add(:base, "We have only #{product.available_stocks} #{product.name} available, we are out of stock.") if invoice_item.qty > product.available_stocks
    end
  end

  def set_service_start_time
    self.service_start_time = Time.zone.now
  end

  def set_invoice_id
    return if customer_id.present?
    return if customer_email.blank?

    customer = Customer.find_by(email: customer_email)
    if customer.blank?
      generated_password = Devise.friendly_token(64)
      name = customer_name.split
      customer = Customer.create(first_name: name[0], last_name: name[1], phone: customer_phone, email: customer_email, password: generated_password, password_confirmation: generated_password)
    end
    update(customer_id: customer.id)
  end

  def invoice_status_change_notification
    return unless status_changed?

    invoice_url = Rails.application.routes.url_helpers.users_invoice_url(id)

    case status
    when 'parts_approved'
      User.joins(:role).where('lower(roles.name) = ? or users.id = ?', 'supervisor', user_id).find_each do |supervisor|
        current_admin.notifications.create(to_user_id: supervisor.id, css_class: 'alert-success', notification_body: "#{current_admin.name} is approved requested parts. please check the <a href='#{invoice_url}'>work order</a>")
      end
      invoice_items.each do |invoice_item|
        next if invoice_item.product.blank?

        product = invoice_item.product
        product.update(available_stocks: (product.available_stocks - invoice_item.qty))
      end
    when 'parts_rejected'
      User.joins(:role).where('lower(roles.name) = ? or users.id = ?', 'supervisor', user_id).find_each do |supervisor|
        current_admin.notifications.create(to_user_id: supervisor.id, css_class: 'alert-success', notification_body: "#{current_admin.name} is rejected requested parts, reason for rejection is '#{parts_rejection_comment.html_safe}'. please check the <a href='#{invoice_url}'>invoice</a>")
      end
    when 'completed'
      User.joins(:role).where('lower(roles.name) = ?', 'supervisor').find_each do |supervisor|
        current_admin.notifications.create(to_user_id: supervisor.id, css_class: 'alert-success', notification_body: "#{current_admin.name} marked invoice to completed. please check the <a href='#{invoice_url}'>invoice</a>")
      end
    when 'paid'
      # send notification
      return unless current_admin != user

      User.joins(:role).where('lower(roles.name) = ? OR lower(roles.name) = ?', 'admin', 'manager').find_each do |_supervisor|
        current_admin.notifications.create(to_user_id: user.id, css_class: 'alert-success', notification_body: "#{current_admin.name} marked invoice to paid. please check the <a href='#{invoice_url}'>invoice</a>")
      end
    end
  end

  def create_notifications
    User.joins(:role).where('lower(roles.name) IN (?)', ['admin', 'manager', 'supervisor', 'product manager']).find_each do |admin_user|
      invoice_url = Rails.application.routes.url_helpers.users_invoice_url(id)
      user.notifications.create(to_user_id: admin_user.id, css_class: 'alert-info', notification_body: "#{user.name} open a work order for #{begin
        customer.name
      rescue StandardError
        '-'
      end}. please check the <a href='#{invoice_url}'>work order</a>")
    end
  end

  def set_customer_id_to_vehicles
    return if customer_id.blank?

    return unless vehicle.present? && vehicle.customer_id.nil?

    vehicle.update(customer_id:)
  end

  def generate_invoice_number
    last_invoice = Invoice.order(:created_at).last
    if last_invoice
      # Extract the numeric part and increment it
      last_number = last_invoice.invoice_number[/\d+/].to_i
      new_number = last_number + 1
    else
      new_number = 1 # Start with 1 if no previous invoice exists
    end

    # Format the new invoice number
    self.invoice_number = format_invoice_number(new_number)
  end

  def format_invoice_number(number)
    "BRG#{number.to_s.rjust(4, '0')}" # Pad with zeros to ensure 4 digits
  end
end
