class Admin::PaymentMethodsController < Admin::BaseController
  def new
    @payment_method = Payment_method.new
  end

  def show
    @payment_method = Payment_method.find_by id: payment_method_params[:id]
    if @payment_method.blank?
      flash[:danger] = t ".payment_method"
      redirect_to admin_payment_method_path
    else
      flash[:sussess] = t ".empty_payment_methhod"
      render :new
    end
  end

  def index
    @payment_methods = Payment_method.newest.paginate(page: params[:page])
      .per_page Settings.number_page
    if @payment_methods.empty?
      flash[:sussess] = t ".index_payment_method"
      @payment_methods
    else
      flash[:danger] = t ".not_find_payment_method"
      render :home
    end
  end

  def create
    @payment_method = Payment_method.new payment_method_params
    if @payment_method.save
      flash[:sussess] = t ".create_payment_methods"
      redirect_to content_path
    else
      flash[:danger] = t ".unsuccessful_payment_methods"
      render :new
    end
  end

  private
  def payment_method_params
    params.require(:payment_methods).permit :payment_name, :config,
      :description, :payment, :payment_info, :security, :message
  end
end
