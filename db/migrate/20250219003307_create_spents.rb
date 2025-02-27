class CreateSpents < ActiveRecord::Migration[8.0]
  def change
    create_table :spents do |t|
      t.text :motive
      t.decimal :amount, precision: 5, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
