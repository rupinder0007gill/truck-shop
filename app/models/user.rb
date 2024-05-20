# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
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
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_archived_at           (archived_at)
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_for,
                  against: %i[first_name last_name phone email],
                  using: {
                    tsearch: { prefix: true }
                  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # We removed ":registerable" in this case...as they need to receive an invite
  devise :invitable, :database_authenticatable, :lockable,
         :recoverable, :rememberable, :validatable, :trackable

  ##############################################################################
  ### Attributes ###############################################################

  ##############################################################################
  ### Constants ################################################################

  ##############################################################################
  ### Includes and Extensions ##################################################

  ##############################################################################
  ### Callbacks ################################################################
  after_initialize :set_default_role, if: :new_record?
  after_initialize :set_password_if_nil, if: :new_record?

  ##############################################################################
  ### Associations #############################################################
  has_one_attached :avatar
  belongs_to :role
  has_many :products, dependent: :restrict_with_error
  has_many :orders, dependent: :restrict_with_error
  has_many :invoices, dependent: :restrict_with_error
  has_many :notifications, dependent: :restrict_with_error
  has_many :admin_notifications, class_name: 'Notification', foreign_key: 'to_user_id', dependent: :restrict_with_error

  ##############################################################################
  ### Validations ##############################################################
  validates :first_name, :last_name, presence: true

  ##############################################################################
  ### Scopes ###################################################################

  ##############################################################################
  ### Other ####################################################################

  ##############################################################################
  ### Class Methods ############################################################

  def name
    [first_name, last_name].compact.join(' ')
  end

  def active_for_authentication?
    super && archived_at.nil? # i.e. super && self.is_active
  end

  def inactive_message
    'Sorry, this account has been disabled.'
  end

  def has_any_role?
    role.name == 'Admin' || role.name == 'Manager' || role.name == 'Technician'
  end

  ##############################################################################
  ### Instance Methods #########################################################

  #########

  # protected

  #########

  #######

  private

  #######

  def set_default_role
    self.role ||= Role.find_by(name: 'Technician')
  end

  def set_password_if_nil
    return if password.present?

    generated_password = Devise.friendly_token(64)
    self.password = generated_password
    self.password_confirmation = generated_password
  end
end
