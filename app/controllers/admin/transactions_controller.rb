class Admin::TransactionsController < Admin::BaseController
  before_action :load_transations, only: [:show, :update]

  def create
    @transaction = Transations.new transations_params
    if @transaction.save
      flash[:sussess] = t ".create_transations"
      redirect_to @transaction
    else
      flash[:danger] = t ".fails"
      render :new
    end
  end

  def new
    @transaction = Transations.new
  end

  def show
    if @transaction.empty?
      flash[:success] = t ".transaction"
      redirect_to static_pages_home_path
    else
      flash[:danger] = t ".empty_transaction"
      render :new
    end
  end

  def update
    if @transactions.update_attributes transations_params
      flash[:success] = t ".update_transactions"
      redirect_to transactions_admin_path
    else
      flash[:danger] = t ".cant_update_transactions"
      render :edit
    end
  end

  def index
    @transactions = Transations.newest.paginate(page: params[:page])
      .per_page Settings.number_page
    if @transactions
      redirect_to index_admin_transactions_path
    else
      render :index
    end
  end

  private
  def transations_params
    params.require(:transactions).permit :status, :amount
  end

  def load_transations
    @transaction = Transations.find_by id: params[:id]
    if @transaction.blank?
      redirect_to static_pages_home_path
    end
  end
end
