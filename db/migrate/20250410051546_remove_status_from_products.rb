class RemoveStatusFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :status
  end
end
