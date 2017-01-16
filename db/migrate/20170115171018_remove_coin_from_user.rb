class RemoveCoinFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :coin, :integer
  end
end
