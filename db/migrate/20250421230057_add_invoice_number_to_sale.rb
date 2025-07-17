class AddInvoiceNumberToSale < ActiveRecord::Migration[8.0]
  def change
    add_column :sales, :invoice_number, :string
  end
end
