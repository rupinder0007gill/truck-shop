# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                            :bigint           not null, primary key
#  archived_at                   :datetime
#  available_stocks              :bigint           default(0)
#  deleted_at                    :datetime
#  discount_percentage           :integer
#  manufacturar_name             :string
#  name                          :string
#  price_cents                   :bigint
#  product_identification_number :string
#  product_summary               :string
#  release_date                  :datetime
#  selling_price_cents           :bigint
#  slug                          :string
#  status                        :integer          default("draft"), not null
#  total_stocks                  :bigint           default(0)
#  used_stocks                   :bigint           default(0)
#  warranty_length               :string
#  warranty_policy               :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  user_id                       :bigint
#
# Indexes
#
#  index_products_on_deleted_at  (deleted_at)
#  index_products_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  ##############################################################################
  ### Attributes ###############################################################
  monetize :price_cents
  monetize :selling_price_cents, disable_validation: true

  ##############################################################################
  ### Constants ################################################################
  attr_accessor :add_stock

  ##############################################################################
  ### Includes and Extensions ##################################################

  ##############################################################################
  ### Callbacks ################################################################
  before_save :sanitize_slug, :set_selling_price, :add_stocks
  before_create :init_slug

  ##############################################################################
  ### Associations #############################################################
  has_many_attached :images
  has_rich_text :description
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products
  belongs_to :user

  ##############################################################################
  ### Validations ##############################################################
  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true
  validates :discount_percentage, numericality: { in: 0..100, message: 'Discount must be in range of 0 to 100' }

  ##############################################################################
  ### Scopes ###################################################################
  scope :published_products, -> { where(status: 1) }
  scope :draft_products, -> { where(status: 0) }

  ##############################################################################
  ### Other ####################################################################
  enum status: {
    draft: 0,
    publish: 1
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
  def set_selling_price
    discount_price = 0
    discount_price = (price_cents * discount_percentage) / 100 if price.present? && discount_percentage.present?
    self.selling_price = Money.new((price_cents - discount_price), 'CAD')
  end

  def add_stocks
    return unless add_stock.present? && add_stock.to_i.positive?

    self.total_stocks = total_stocks + add_stock.to_i
    self.available_stocks = available_stocks + add_stock.to_i
  end

  def init_slug
    i = 1
    slug = name.parameterize
    while self.slug.nil?
      slug = if i > 1
               "#{name.parameterize}-#{i}"
             else
               name.parameterize
             end
      check = Product.find_by(slug:)
      # throw check
      self.slug = slug if check.nil?
      i += 1
    end
  end

  def sanitize_slug
    self.slug = slug.parameterize if slug.present?
  end
end
