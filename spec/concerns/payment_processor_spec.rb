require 'rails_helper'

describe PaymentProcessor do
  let(:funded_amount) {100.00}
  let(:payment_amount) {10.00}
  let(:date) {1.day.ago}
  let!(:loan) {create :loan, funded_amount: funded_amount }
  let!(:payment) {create :payment, loan: loan, amount: payment_amount, payment_date: date}
  let!(:second_payment) {create :payment, loan: loan, amount: payment_amount, payment_date: date}
  let(:processor) {PaymentProcessor.new(loan)}

  it 'applies a payment' do
    expect(processor.apply!(amount: payment_amount)).to be_truthy
  end

  it "won't apply a payment if it's greater than the outstanding balance" do
    expect(processor.apply!(amount: loan.outstanding_balance + 1)).to be_falsey
  end

  it 'returns an error if the payment is refused' do
    processor.apply!(amount: loan.outstanding_balance + 1)
    expect(processor.errors.keys).to eql [:refused]
  end
end
