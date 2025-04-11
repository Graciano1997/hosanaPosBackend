class AddReceivedTpaToSale < ActiveRecord::Migration[8.0]
  def change
    add_column :sales, :received_tpa, :decimal
  end
end
