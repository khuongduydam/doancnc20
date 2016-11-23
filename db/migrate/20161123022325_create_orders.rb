class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :status
      t.string :note
      t.integer :total_price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
