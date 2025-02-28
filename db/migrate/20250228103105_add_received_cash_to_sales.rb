class AddReceivedCashToSales < ActiveRecord::Migration[8.0]
  def change
    add_column :sales, :received_cash, :decimal
  end
end
