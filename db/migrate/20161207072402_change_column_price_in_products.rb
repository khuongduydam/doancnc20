class ChangeColumnPriceInProducts < ActiveRecord::Migration[5.0]
  def up
    change_column :products, :price, :decimal, precision: 5, scale: 2
  end
  def down
    change_column :products, :price, :integer
  end
end
