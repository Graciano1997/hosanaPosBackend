class AddNewFieldsToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :cost_price, :decimal, precision: 5, scale: 2
    add_column :products, :mesure_unit, :string
    add_column :products, :brand, :string
    add_column :products, :description, :text
    add_column :products, :status, :string
    add_column :products, :weight, :decimal
    add_column :products, :dimension, :string
    add_column :products, :location_in_stock, :string
    add_column :products, :taxes, :decimal
    add_column :products, :keyword, :string
    add_column :products, :observation, :text
    add_column :products, :promotion, :boolean
    add_column :products, :discount, :decimal
    add_column :products, :product_type, :string
  end
end
