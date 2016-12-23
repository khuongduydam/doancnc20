class ChangeTypeOfCoinOnUserPriceOnProduct < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :coin, :integer
    change_column :products, :price, :integer
  end
  def down
    change_column :users, :coin, :decimal, precision: 9, scale: 5
    change_column :products, :price, :decimal, precision: 8, scale: 2
  end
end
