class ChangeStatusOrderMembers < ActiveRecord::Migration[5.0]
  def up
    change_column :order_members, :status, :string, default: 'Uncomplete'
  end

  def down
    change_column :order_members, :status, :string
  end
end
