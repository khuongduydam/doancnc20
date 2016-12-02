class AddOrderMemberIdToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :order_member_id, :integer
  end
end
