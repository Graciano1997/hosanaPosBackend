class RemoveProductTypeFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :product_type
  end
end
