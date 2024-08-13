# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  archived_at         :datetime
#  available_stocks    :bigint           default(0)
#  base_price_cents    :bigint
#  core_price_cents    :bigint
#  deleted_at          :datetime
#  name                :string
#  product_number      :string
#  selling_price_cents :bigint
#  slug                :string
#  total_stocks        :bigint           default(0)
#  used_stocks         :bigint           default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_products_on_deleted_at  (deleted_at)
#
class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for,
                  against: %i[name product_number],
                  using: {
                    tsearch: { prefix: true }
                  }
  ##############################################################################
  ### Attributes ###############################################################
  monetize :base_price_cents
  monetize :core_price_cents, disable_validation: true
  monetize :selling_price_cents, disable_validation: true

  ##############################################################################
  ### Constants ################################################################
  attr_accessor :add_stock

  ##############################################################################
  ### Includes and Extensions ##################################################

  ##############################################################################
  ### Callbacks ################################################################
  before_save :sanitize_slug, :add_stocks
  before_create :init_slug

  ##############################################################################
  ### Associations #############################################################
  # has_many_attached :images
  # has_rich_text :description
  # has_many :order_products, dependent: :destroy
  # has_many :orders, through: :order_products
  # belongs_to :user

  ##############################################################################
  ### Validations ##############################################################
  validates :product_number, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  ##############################################################################
  ### Scopes ###################################################################
  scope :available_stocks, -> { where('available_stocks > 1') }

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

  private

  #######
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
