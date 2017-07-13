class Admin::OrderDetailsController < Admin::BaseController

  def new
    @orderdetail = OrderDetail.new
  end

  def show
    @orderdetail = OrderDetail.find_by id: orderdetail_params[:id]
    if @orderdetail
      flash[:sussess] = t ".orderdetail"
      redirect_to admin_order_detail_path
    else
      flash[:danger] = t ".orderdetail_empty"
      redirect_to new_admin_order_detail_path
    end
  end

  def index
    @orderdetails = OrderDetail.newest.paginate(page: params[:page])
      .per_page Settings.number_page
    if @orderdetails
      flash[:danger] = t ".order_details"
      redirect_to admin_order_detail_path
    end
  end

  def create
    @orderdetail = OrderDetail.new orderdetail_params
    if @orderdetail.save
      flash[:sussess] = t ".create_orrder_detail"
      redirect_to @orderdetail
    else
      flash[:danger] =  t ".fails"
      render :new
    end
  end

  private
  def orderdetail_params
    params.require(:order_details).permit :quantity, :price
  end
end
