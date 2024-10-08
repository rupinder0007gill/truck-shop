# frozen_string_literal: true

class Users::UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy enable_user]
  load_and_authorize_resource

  def index
    @search_url = users_users_path
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction].presence_in(%w[asc desc]) || 'desc'

    @users = if params[:query].present?
               User.includes(:role).search_for(params[:query])
             else
               User.includes(:role).all
             end
    @pagy, @users = pagy(@users.order("#{sort_column} #{sort_direction}"), items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream # Respond to Turbo Stream requests
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_users_url, notice: 'User created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user.password = params[:user][:password] unless params[:user][:password].to_s.empty?
    @user.avatar.purge if params[:user][:remove_avatar] == '1'
    if @user.update(user_params)
      redirect_to users_users_url, notice: 'User updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @user.destroy
    @user.update(archived_at: DateTime.now)
    redirect_to users_users_url, alert: 'User disabled successfully.'
  end

  def enable_user
    @user.update(archived_at: nil)
    redirect_to users_users_url, alert: 'User enabled successfully.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :role_id, :avatar)
  end
end
