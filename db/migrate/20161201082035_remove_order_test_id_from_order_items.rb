class RemoveOrderTestIdFromOrderItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :order_items, :order_test_id
  end
end
