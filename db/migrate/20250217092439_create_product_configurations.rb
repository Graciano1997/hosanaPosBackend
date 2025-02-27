class CreateProductConfigurations < ActiveRecord::Migration[8.0]
  def change
    create_table :product_configurations do |t|
      t.string :field
      t.boolean :active
      t.boolean :mandatory

      t.timestamps
    end
  end
end
