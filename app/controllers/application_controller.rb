class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

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
  def extract_locale_from_accept_language_header
    request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
