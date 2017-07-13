class Admin::OrdersController < Admin::BaseController
  before_action :require_admin
  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def new
  	@order = Order.new 
  end

  def show
  	@order = Order.all
  end

  def index
  	@order = Order.newest.paginate(page: params[:page]).per_page Settings.number_page
    if @order.empty?
      render file: "statis_pagr/404"
    else
      @order
    end    
  end

  def create
    @order = Order.new order_params
    if @order.save
      flash[:sussess] = t ".create_order" 
      redirect_to @content
    else
      flash[:danger] = t ".fails"
    end
  end

  private 
    def order_params
      params.require(:orders).permit :full_name, :address, :phone
    end
end
