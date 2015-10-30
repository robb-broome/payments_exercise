require 'rails_helper'

describe Loan do
  let(:date) {1.day.ago}
  let(:funded_amount) {100.00}
  let(:payment_amount) {10.00}
  let!(:loan) {create :loan, funded_amount: funded_amount }
  let!(:payment) {create :payment, loan: loan, amount: payment_amount, payment_date: date}
  let!(:second_payment) {create :payment, loan: loan, amount: payment_amount, payment_date: date}

  it 'has outstanding balance' do
    expect(loan.outstanding_balance).to eq(80)
  end
end
