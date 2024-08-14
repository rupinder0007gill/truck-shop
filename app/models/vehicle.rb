# frozen_string_literal: true

# == Schema Information
#
# Table name: vehicles
#
#  id             :bigint           not null, primary key
#  archived_at    :datetime
#  deleted_at     :datetime
#  licence_number :string
#  make_model     :string
#  po_number      :string
#  unit_number    :string
#  vin            :string
#  year           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :bigint
#
# Indexes
#
#  index_vehicles_on_customer_id  (customer_id)
#  index_vehicles_on_deleted_at   (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
class Vehicle < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for,
                  against: %i[vin licence_number po_number],
                  using: {
                    tsearch: { prefix: true }
                  }

  ##############################################################################
  ### Attributes ###############################################################

  ##############################################################################
  ### Constants ################################################################

  ##############################################################################
  ### Includes and Extensions ##################################################

  ##############################################################################
  ### Callbacks ################################################################

  ##############################################################################
  ### Associations #############################################################
  has_many :invoices, dependent: :destroy
  belongs_to :customer

  ##############################################################################
  ### Validations ##############################################################
  validates :vin, presence: true, uniqueness: true
  validates :licence_number, presence: true, uniqueness: true
  validates :po_number, uniqueness: true

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
