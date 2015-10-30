FactoryGirl.define do
  factory :payment do
    amount 9.00
    payment_date 1.day.ago
    loan
  end
end
