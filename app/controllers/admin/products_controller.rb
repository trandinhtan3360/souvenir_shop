class Admin::ProductsController < Admin::BaseController
  before_action :require_admin

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_product" 
      redirect_to admin_product_path
    else
      flash[:danger] = t ".fails"
    end
  end

  def show
    @product = Product.find_by_id params[:id]
  end

  def index
    @product = Product.all
  end

  private
    def product_params
      params.require(:product).permit :name, :price, :comment, :discount, :image
    end
end
