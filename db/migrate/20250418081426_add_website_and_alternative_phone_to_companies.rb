class AddWebsiteAndAlternativePhoneToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :website, :string
    add_column :companies, :alternative_phone, :string
  end
end
