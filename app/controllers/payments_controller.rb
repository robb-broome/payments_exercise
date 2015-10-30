class PaymentsController < ApplicationController

  before_action :loan

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def show
    payment = @loan.payments.find(params[:id])
    render json: payment
  end

  def index
    render json: @loan.payments
  end

  def create
    payment_processor = PaymentProcessor.new(@loan)
    if (payment_processor.apply! payment_params)
      render json: {}, status: :created
    else
      render json: payment_processor.errors, status: :forbidden
    end
  end

  private

  def loan
    @loan = Loan.find params[:loan_id]
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date)
  end
end
