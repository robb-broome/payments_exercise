class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.datetime :payment_date
      t.references :loan, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
