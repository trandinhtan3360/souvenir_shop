class SessionsController < ApplicationController
  def create
    user = User.find_by email: params[:session][:email]
    if user && user.authenticate params[:session][:password]
      login_url user
      flash.now[:succes] = t ".message_sigin"
      redirect_to user
    else
      flash.now[:danger] = t ".error_message"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
