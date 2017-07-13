class Admin::CommentsController < Admin::BaseController
  before_action :load_comment, only: [:show, :update]

  def create
    @comment = Comment.new comment_params
    if @comment.save
      flash[:sussess] = t ".create_comment"
      redirect_to @comment
    else
      flash[:danger] = t ".fails"
      render :new
    end
  end


  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.newest.paginate(page: params[:page])
      .per_page Settings.number_page
    if @comments
      flash[:sussess] = t ".index_comment"
      redirect_to index_admin_comment_path
    end
  end


  def update
    if @comment.update_attributes comment_params
      flash[:sussess] = t ".update_comment"
      redirect_to @comment
    else
      flash[:danger] = t ".unsuss"
      render :show
    end
  end

  private
  def comment_params
    params.require(:comments).permit :content
  end

  def load_comment
    @comment = Comment.find_by :id comment_params[:id]
    if @comment.present?
      flash[:sussess] = t ".load_comment_successful"
      redirect_to admin_comment_path
    else
      flash[:danger] = t ".load_comment_unsuccessful"
      render :new
    end
  end
end
