class AddPaymentTypeToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :payment_type, :string
  end
end