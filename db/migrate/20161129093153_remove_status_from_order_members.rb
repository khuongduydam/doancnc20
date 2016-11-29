class RemoveStatusFromOrderMembers < ActiveRecord::Migration[5.0]
  def change
    remove_column :order_members, :status
  end
end
