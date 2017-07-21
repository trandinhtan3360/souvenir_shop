class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show
    if Product.exists? params[:id]
      @product = Product.find params[:id]
    else
      flash[:danger] = t "product.not_product"
      redirect_to products_path
    end
  end
end
