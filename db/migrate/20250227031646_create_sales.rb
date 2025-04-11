class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.integer :qty
      t.string :payment_way
      t.decimal :descount
      t.decimal :difference
      t.decimal :total
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
