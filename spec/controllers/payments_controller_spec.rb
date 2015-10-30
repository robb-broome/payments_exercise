require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do

  let(:funded_amount) {100.00}
  let(:payment_amount) {10.00}
  let!(:loan) {create :loan, funded_amount: funded_amount }
  let!(:payment) {create :payment, loan: loan, amount: payment_amount, payment_date: date}
  let!(:second_payment) {create :payment, loan: loan, amount: payment_amount, payment_date: date}
  let(:date) {1.day.ago}

  describe '#show' do
    it 'shows a payment' do
      get :show, loan_id: loan, id: payment
      response_data = JSON.parse response.body
      expect(response_data['amount']).to eq(payment_amount.to_s)
    end
  end

  describe '#index' do
    it 'lists all the payments for a loan' do
      get :index, loan_id: loan
      expect(JSON.parse(response.body).count).to eq(2)
    end

  end

  describe '#create' do
    it 'creates a payment and returns' do
      data = {amount: 10.00}
      post :create, loan_id: loan, payment: data
      expect(response.status).to eq 201
    end

    it 'returns a reasonable error if a payment would exceed the open balance on the loan' do
      data = {amount: funded_amount + 1}
      post :create, loan_id: loan, payment: data
      expect(JSON.parse(response.body).keys).to eq ['refused']
    end
  end

end

