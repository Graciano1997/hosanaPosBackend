class AddSaleObservationToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :sale_observation, :string
  end
end
