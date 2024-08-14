# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id                     :bigint           not null, primary key
#  address                :string
#  archived_at            :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  deleted_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_customers_on_archived_at           (archived_at)
#  index_customers_on_deleted_at            (deleted_at)
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_invitation_token      (invitation_token) UNIQUE
#  index_customers_on_invited_by            (invited_by_type,invited_by_id)
#  index_customers_on_invited_by_id         (invited_by_id)
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#  index_customers_on_unlock_token          (unlock_token) UNIQUE
#
class Customer < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for,
                  against: %i[first_name last_name phone email],
                  using: {
                    tsearch: { prefix: true }
                  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :lockable,
         :recoverable, :rememberable, :trackable

  has_one_attached :avatar
  has_many :invoices, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :notifications
  ### Validations ##############################################################
  validates :email, presence: true, uniqueness: true
  validates :phone, uniqueness: true, if: -> { phone.present? }

  ##############################################################################
  ### Class Methods ############################################################

  def name
    [first_name, last_name].compact.join(' ')
  end
end
