class AddManufactureDateToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :manufacture_date, :date
  end
end
