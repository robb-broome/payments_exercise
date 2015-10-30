class Loan < ActiveRecord::Base
  has_many :payments

  def outstanding_balance
    funded_amount - payments.sum(:amount)
  end

  def as_json opts
    {
      id: id,
      created_at: created_at,
      funded_amount: funded_amount,
      outstanding_balance: outstanding_balance
    }
  end
end
