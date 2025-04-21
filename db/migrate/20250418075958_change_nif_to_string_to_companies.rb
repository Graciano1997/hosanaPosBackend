class ChangeNifToStringToCompanies < ActiveRecord::Migration[8.0]
  def change
    change_column :companies, :nif, :string
  end
end
