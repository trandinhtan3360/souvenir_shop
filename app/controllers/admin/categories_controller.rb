class Admin::CategoriesController < Admin::BaseController
  before_action :load_catrgory, only: [:show, :update]

  def new
   @category = Category.new
  end

  def index
   @categories = Category.newest.paginate(page: params[:page])
     .per_page Settings.number_page
  end

  def show
    if @category
      flash[:sussess] = t ".show_category"
      redirect_to admin_category_path
    else
      flash[:danger] = t ".create_category"
      render :new
    end
  end

  def create
    @category = Category.new categories_params
    if @categories.save
      flash[:sussess] = t ".create_categories"
      redirect_to admin_category_path(@category)
    else
      flash[:danger] =  t ".fails"
      render :new
    end
  end

  def update
    if @category.update_attributes categories_params
      flash[:sussess] = t ".update_categori"
      redirect_to @categories
    else
      flash[:danger] = t ".unsuccessful_category"
      render :edit
    end
  end

  private
  def categories_params
    params.require(:category).permit :name, :sort_order
  end

  def load_catrgory
    @category = Category.find_by id: params[:id]
    if @category
      flash[:danger] = t ".category_message"
      redirect_to admin_category_path
    end
  end
end
