class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: [:update, :show]

  def create
    @order = Order.new order_params
    if @order.save
      flash[:sussess] = t ".create_order"
      redirect_to @order
    else
      flash[:danger] = t ".fails"
      render :new
    end
  end

  def new
    @order = Order.new
  end

  def show
    if @order.empty?
      flash[:danger] = t ".order_empty"
      render :new
    else
      flash[:sussess] = t ".order"
      redirect_to admin_order_path
    end
  end

  def index
   @orders = Order.newest.paginate(page: params[:page]).per_page Settings.number_page
    if @orders.empty?
      flash[:sussess] = t ".index_order"
      redirect_to index_admin_orders_path
    else
      flash[:danger] = t ".fails_index_order"
      redirect_to admin_order_path
    end
  end

  def update
    if @order.update_attributes order_params
      flash[:sussess] = t ".update_order"
      redirect_to admin_order_path
    end
  end

  private
  def order_params
    params.require(:orders).permit :full_name, :address, :phone
  end

  def load_order
    @order = Order.find_by :id order_params[:id]
    if @order
      render file: "admin/orders/new"
    end
  end
end
