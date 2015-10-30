class PaymentProcessor
  attr_accessor :loan, :errors

  def initialize loan
    @loan = loan
    @errors = {}
  end

  def apply! opts
    if status = validate(opts)
      loan.payments.create opts
    else
      errors.merge! refused: 'Payment would exceed amount owed.'
    end
    status
  end

  def validate opts
    loan.outstanding_balance >= opts[:amount].to_f
  end
end
