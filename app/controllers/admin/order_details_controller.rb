class Admin::OrderDetailsController < Admin::BaseController
  before_action :require_admin
  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def new
    @orderDetail = OrderDetail.new
  end

  def show
    @orderDetail = OrderDetail.all
  end

  def index
    @orderDetail = OrderDetail.newest.paginate(page: params[:page]).per_page Settings.number_page
    if @orderDetail.empty?
      render file: "static_pages/404"
    else
      @orderDetail 
    end
  end

  def create
    @orderDetail = OrderDetail.new orderDetail_params
    if @orderDetail.save
      flash[:sussess] = t(".create_orrder_detail") 
      redirect_to @orderDetail
    else
        flash[:danger] =  t ".fails"
        render :new
    end
  end

  private 
    def orderDetail_params 
      params.require(:order_details).permit :quantity, :price
    end
end