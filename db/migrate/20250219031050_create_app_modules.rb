class CreateAppModules < ActiveRecord::Migration[8.0]
  def change
    create_table :app_modules do |t|
      t.string :name

      t.timestamps
    end
  end
end
