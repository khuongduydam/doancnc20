class ChangeDataTypeOfCoinFormUser < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :coin, :decimal, precision: 9, scale: 5
  end
  def down
    change_column :users, :coin, :integer
  end
end
