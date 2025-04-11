class AddOutputToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :output, :integer
  end
end
