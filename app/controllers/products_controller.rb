class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_product" 
      redirect_to new_admin_product_path
    else
      flash[:danger] = t ".fails"
    end
  end

  def show
    @product = Product.all
  end

  def index
   @product = Product.all
  end


  private
    def product_params
      params.require(:products).permit :name, :price, :comment, :discount, :image_link
    end
end