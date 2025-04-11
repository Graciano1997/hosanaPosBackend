class CreateExpiredProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :expired_products do |t|
      t.date :expired_on
      t.integer :qty
      t.decimal :total
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
