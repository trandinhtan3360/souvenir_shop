class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def correct_user
    @user = User.find_by params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".please_login."
      redirect_to login_url
    end
  end

  protected
  def require_admin
    unless current_user.admin?
      flash[:danger] = t ".not_admin"
      redirect_to root_path
    end
  end
end
