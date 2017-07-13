class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".send_email_password"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_not_fount"
      render :new
    end
  end

  def edit
    @user = User.find_by email: params[:password_reset][:email]
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t(".empty_password"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t ".message_password"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def valid_user
    unless (@user && @user.activated? &&
      @user.authenticated?(:activation, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t ".password_reset"
      redirect_to new_password_reset_url
    end
  end

  def get_user
    @user = User.find_by email: params[:email]
    @user.dowcase
    if @user.present?
      flash[:success] = t ".successfuly"
      redirect_to edit_user_path
    else
      flash[:danger] = t ".unsuccessfuly"
      redirect_to user_path
    end
  end
end
