class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find_by params[:id]
    if @user.blank? 
      render 404
    else
      @user
    end
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new user_params 
    if @user.save
      log_in @user
      flash[:success] =  t(".message_sigin")
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    @user = User.find_by params[:id]
  end

  def update
    @user = User.find_by params[:id]
    if @user.update_attributes(user_params)
     flash[:success] = t(".update_profile")
     redirect_to @user
    else
      render edit
    end
  end

  def destroy
    User.find_by params[:id].destroy
    flash[:success] = t(".user_delete")
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password,:password_confirmation
    end

    def set_user
      @user = User.find_by params[:id]  
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t(".please_login.")
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find_by params[:id]
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
