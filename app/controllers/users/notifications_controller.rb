# frozen_string_literal: true

class Users::NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show]

  def index
    @notifications = Notification.where('to_user_id = ?', current_user.id).order(created_at: :desc)
  end

  def show; end
end
