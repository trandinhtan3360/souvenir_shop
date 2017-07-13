class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.newest.paginate(page: params[:page])
      .per_page Settings.number_page
    if @users
      flash[:success] = t ".index_user"
      redirect_to users_path
    else
      flash[:danger] = t ".empty_user"
      redirect_to root_path
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] =  t ".message_sigin"
      redirect_to @user
    else
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
      params.require(:user).permit :name, :email, :password,
        :password_confirmation
    end

    def load_user
      @user = User.find_by :id user_paramsus[:id]
      unless @user
        flash[:danger] = t ".user_all"
        redirect_to users_url
      end
    end
end
