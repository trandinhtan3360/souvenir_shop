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

  def verify_admin
    redirect_to(root_url) unless current_user.admin?
  end

  private
  def create_cart
    @cart = Cart.build_from_hash session[:cart]
    @cart_group = @cart.items.group_by(&:shop_id).map  do |q|
      {shop_id: q.first, items: q.second.each.map { |qn| qn }}
    end
  end
end
