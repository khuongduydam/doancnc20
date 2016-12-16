class AddTotalPriceToOrderMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :order_members, :total_price, :integer
  end
end
