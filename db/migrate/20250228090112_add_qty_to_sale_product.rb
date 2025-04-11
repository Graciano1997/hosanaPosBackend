class AddQtyToSaleProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :sale_products, :qty, :integer
    add_column :sale_products, :subtotal, :decimal
  end
end
