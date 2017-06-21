class UsersController < ApplicationController
  def show
    @user = User.find_by params[:id]
    if @user.blank? 
      render 404
    end
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new user_params   # Not the final implementation!
    if @user.save
      flash[:success] =  t(".message_sigin")
      redirect_to @user
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password,
        :password_confirmation
    end
end

