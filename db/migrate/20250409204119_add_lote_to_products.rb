class AddLoteToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :lote, :string
  end
end
