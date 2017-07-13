class Admin::UsersController < Admin::BaseController
  before_action :require_admin
  before_action :verify_admin, only: :destroy
  
  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def new
    @users = User.new
  end

  def show
  end

  def index
    @users = User.all
  end

  def edit
     @user = User.find_by params[:id]
  end

  def destroy
    User.find_by params[:id].destroy
    flash[:success] = "User deleted"
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

    def verify_admin
      redirect_to(root_url) unless current_user.admin?
    end
end
