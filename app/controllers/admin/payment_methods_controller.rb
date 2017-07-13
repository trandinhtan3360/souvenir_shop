class Admin::PaymentMethodsController < Admin::BaseController

  def new
    @payment_method = PaymentMethod.new
  end

  def show
    @payment_method = PaymentMethod.find_by id: paymentmethod_params[:id]
    if @payment_method.empty?
      flash[:sussess] = t ".payment_method"
      redirect_to admin_payment_method_path
    else
      flash[:danger] = t ".empty_payment_method"
      redirect_to new_admin_payment_method_path
    end
  end

  def index
    @payment_methods = PaymentMethod.newest.paginate(page: params[:page])
      .per_page Settings.number_page
    if @payment_methods
      flash[:danger] = t ".payment_methods"
      redirect_to admin_payment_method_path
    end
  end

  def create
    @payment_method = PaymentMethos.new paymentmethod_params
    if @payment_method.save
      flash[:sussess] = t ".create_payment_methods"
      redirect_to @payment_method
    else
      flash[:danger] = t ".fails"
      redirect_to new_admin_payment_method_path
    end
  end

  private
  def paymentmethod_params
    params.require(:payment_methods).permit :payment_name, :config,
      :description, :payment,:payment_info, :security, :message
  end
end
