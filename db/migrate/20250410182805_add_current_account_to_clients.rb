class AddCurrentAccountToClients < ActiveRecord::Migration[8.0]
  def change
    add_column :clients, :current_account, :string
  end
end
