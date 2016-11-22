class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :origin
      t.string :description
      t.integer :quantity
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, [:category_id, :created_at]
  end
end
