class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, except: [:new, :create, :index]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".message_sigin"
      redirect_to @user
    else
      flash[:danger] = t ".unsuccessful_sigin"
      render :new
    end
  end

  def edit
  end

  def update
    unless  @user.present?
      @user.update_attributes user_params
      flash[:success] = t ".update_profile"
        redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_delete"
      redirect_to users_path
    else
      flash[:danger] = t ".delete_user_empty"
      render file: "static_pages/home"
    end
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def load_user
      @user = User.find_by id: params[:id]
      unless @user
        flash[:danger] = t ".user_all"
        @user
      end
    end
end
