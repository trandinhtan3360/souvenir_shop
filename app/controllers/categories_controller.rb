class CategoriesController < ApplicationController
  def show
    if Category.exists? params[:id]
      @category = Category.find params[:id]
    else
      flash[:danger] = t "flash.danger.load_category"
      redirect_to root_path
    end
  end
end
