class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:edit, :destroy, :show]

  def new
    @user = User.new
  end

  def show
  end

  def index
    @users = User.newest.paginate(page: params[:page]).per_page Settings.number_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:danger] = t ".user_deleted_unsuccessful"
    end
    redirect_to admin_users_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] =  t ".message_sigin"
      redirect_to @user
    else
      flash[:danger] =  t ".fails"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :username, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by params[:id]
    if @user.blank?
      flash[:success] = t ".yes"
      @user
    else
      flash[:danger] = t ".no"
      render :new
    end
  end
end
