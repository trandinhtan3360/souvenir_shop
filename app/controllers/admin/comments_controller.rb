class Admin::CommentsController < Admin::BaseController
  before_action :require_admin
  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def new
    @comment = Comment.new
  end

  def index
    @comment = Comment.all
  end

  def index
    @comment = Comment.newest.paginate(page: params[:page]).per_page Settings.number_page
    if @comment.empty?
      render file: "static_pages/404"
    else
      @comment     
    end
  end

  def create
    @comment = Comment.new comment_params
    if @content.save
      flash[:sussess] = t ".create_comment" 
      redirect_to @content
    else
      flash[:danger] = t ".fails"
    end
  end
  
  def update
    if @comment.update_attributes comment_params
      flash[:sussess] = t ".update_comment"
      redirect_to @comment
    else
      render :edit
    end
  end

  private
    def comment_params
      params.require(:comments).permit :content
    end
end
