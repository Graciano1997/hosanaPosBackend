class CreateAppModuleActions < ActiveRecord::Migration[8.0]
  def change
    create_table :app_module_actions do |t|
      t.references :AppModule, null: false, foreign_key: true
      t.references :AppAction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
