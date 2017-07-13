class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy
  before_action :load_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new 
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new user_params 
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account." 
      redirect_to login_url
    else
      flash[:danger] =  t ".fails"
      render :new
    end
  end
  
  def edit
     @user = User.find params[:id]
  end

  def update
    if @user.update_attributes user_params 
      flash[:success] = t ".update_profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by id: params[:id].destroy
    if @user.empty?
      render file: "static_pages/home"
    else
      flash[:success] = t ".user_delete"
      redirect_to users_url
    end
  end

  private
    def user_params
      params.require(:user).permit :username, :email, :password, :password_confirmation, :phone
    end

    def load_user
      unless @user
        flash[:danger] = t ".user_all"
        redirect_to users_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
