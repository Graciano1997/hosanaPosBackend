class AddExpireDateToProducts < ActiveRecord::Migration[8.0]
  def change
      add_column :products, :expire_date, :date
  end
end
