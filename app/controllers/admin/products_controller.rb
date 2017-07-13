class Admin::ProductsController < Admin::BaseController

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_product"
      redirect_to admin_product_path
    else
      flash[:danger] = t ".fails"
      render :new
    end
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find_by :id params[:id]
    if @product.blank?
      flash[:danger] = t ".empty_product"
      render :new
    else
      redirect_to admin_product_path
    end
  end

  def index
    @products = Product.newest.paginate(page: params[:page])
      .per_page Settings.number_page
    if @products.empty?
      flash[:success] = t ".index_page"
    else
      flash[:danger] = t ".not_index_page"
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product).permit :name, :price, :comment, :discount, :image
  end
end
