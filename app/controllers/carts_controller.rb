class CartsController < ApplicationController
  before_action :load_product, only: :update

  def index
    if @cart.blank?
      flash[:danger] = t "cart.not_product"
    end
  end

  def update
    @cart.add_items params[:id], @product.id
    session["cart"] = @cart.sort
  end

  private
  def load_product
    @product = Product.find_by id: params[:id]
    if @product.blank?
      flash[:success] = t ".flash.success.load_product"
      redirect_to product_path
    else
      flash[:danger] = t ".flash.danger.load_product"
      redirect_to root_path
    end
  end
end
