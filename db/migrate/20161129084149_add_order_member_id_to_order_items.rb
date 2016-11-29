class AddOrderMemberIdToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :order_items, :order_member, foreign_key: true
  end
end
