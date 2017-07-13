class Admin::PaymentMethodsController < Admin::BaseController
  before_action :require_admin

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def new
    @paymentMethos = PaymentMethos.new
  end

  def show
    @paymentMethos = PaymentMethos.all
  end

  def index
    @paymentMethos = PaymentMethos.newest.paginate(page: params[:page]).per_page Settings.number_page
    if @paymentMethos.empty?
      render file: "static_pages/404"
    else
      @paymentMethos
    end
  end

  def create 
    @payment_methods = PaymentMethos.new paymentMethos_params
    if @payment_methods.save
      flash[:sussess] = t ".create_payment_methods" 
      redirect_to @content
    else
      flash[:danger] = t ".fails" 
    end
  end

  private
    def paymentMethos_params
      params.require(:payment_methods).permit :payment_name, :config, :description, :payment,
      :payment_info, :security, :message
    end
end