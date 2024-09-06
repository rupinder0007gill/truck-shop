# frozen_string_literal: true

class Users::NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show]

  def index
    @notifications = Notification.where(to_user_id: current_user.id).order(created_at: :desc)
  end

  def show; end

  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update(is_read_by_receiver: true)
    redirect_to users_notifications_path, notice: 'Notification successfully marked as read.'
  end
end
