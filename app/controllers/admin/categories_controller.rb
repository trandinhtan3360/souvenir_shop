class Admin::CategoriesController < Admin::BaseController

 def new
   @category = Category.new
 end

 def edit
 end

 def index
   @categories = Category.all
 end

 def show
   @category = Category.find_by_id params[:id]
 end

 def create
   @category = Category.new categories_params
   if @categories.save
    flash[:sussess] = t ".create_categories"
    redirect_to admin_category_path(@category)
   else
    flash[:danger] =  t ".fails"
  end
 end

def update
  if @category.update_attributes categories_params
    flash[:sussess] = t ".update_categori"
    redirect_to @categories
  else
    render :edit
  end
end

 private
  def categories_params
    params.require(:category).permit :name, :sort_order 
  end
end
