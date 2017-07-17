class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order

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

  def verify_admin
    redirect_to(root_url) unless current_user.admin?
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
end
