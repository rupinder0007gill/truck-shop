# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Admin Manage All Entities
    can :manage, :all if user.role.name == 'Admin' || user.role.name == 'Manager'

    return unless user.has_any_role?

    can %i[read create search_customer], Invoice
    can %i[read create], Order
    can [:update], Invoice, user:, status: 'pending'
    can [:update], Order, user:, status: 'placed'
    can :manage, Product
    can :manage, Customer

    # can [:edit_current, :update_current], User
    # Conditional TL Scoped Case Management Ability
    # can [:manage], Hrm::Case, user: { team_leader: user }
    # can [:show], Hrm::CaseFile, id: user.case_file_ids

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
