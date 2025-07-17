class CreateInvoiceNumbers < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_numbers do |t|
      t.integer :year
      t.integer :sequency, default: 1

      t.timestamps
    end
  end
end
