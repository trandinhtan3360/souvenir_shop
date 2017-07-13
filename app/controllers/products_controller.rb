class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_product"
      redirect_to product_path
    else
      flash[:danger] = t ".fails"
      render :new
    end
  end

  def index
   @products = Product.newest.paginate(page: params[:page])
    .per_page Settings.number_page
  end

  def show
    @product = Product.find_by id: product_params[:id]
    if @product.empty?
      flash[:danger] = t ".not_product"
      redirect_to new_product_path
    else
      flash[:success] = t ".product"
      redirect_to product_path
    end
  end

  private
  def product_params
    params.require(:products).permit :name, :price, :comment,
      :discount, :image_link
  end
end
