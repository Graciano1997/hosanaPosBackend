class CreateAppPermitions < ActiveRecord::Migration[8.0]
  def change
    create_table :app_permitions do |t|
      t.references :app_module_action, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
