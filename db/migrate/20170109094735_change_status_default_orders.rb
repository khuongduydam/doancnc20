class ChangeStatusDefaultOrders < ActiveRecord::Migration[5.0]
  def up
    change_column :orders, :status, :string, default: 'Uncomplete'
  end
  def down
    change_column :orders, :status, :string
  end
end
