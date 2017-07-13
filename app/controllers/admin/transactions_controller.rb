class Admin::TransactionsController < Admin::BaseController
  before_action :require_admin
  
  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
  
  def new
    @transactions = Transations.new
  end

  def create
    @transactions = Transations.new transations_params
    if @transactions.save
      flash[:sussess] = t ".create_transations"
      redirect_to @transactions
    else
      flash[:danger] = t ".fails"
    end
  end

  def show
    @transactions = Transations.all 
  end

  def index
    @transactions = Transations.newest.paginate(page: params[:page]).per_page Settings.number_page
    if @transactions.empty?
      render file: "static_pages/404"
    else
      @transactions
    end
  end

  def edit
    @transactions = Transations.find_by params[:id]
  end

  def update
    @transactions = Transations.find_by params[:id]
    if @transactions.update_attributes transations_params
      flash[:success] = t ".update_transactions"
      
    end
  end

  private
  def transations_params
    params.require(:transactions).permit :status, :amount
  end
	
end
