class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :info_money
      t.integer :quantity
      t.integer :buying_price

      t.timestamps
    end
  end
end
