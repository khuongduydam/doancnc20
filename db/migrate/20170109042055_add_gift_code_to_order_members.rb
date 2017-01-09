class AddGiftCodeToOrderMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :order_members, :gift_code, :string
  end
end
