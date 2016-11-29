class AddStatusToOrderMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :order_members, :status, :string, default: 'Uncomplete'
  end
end
