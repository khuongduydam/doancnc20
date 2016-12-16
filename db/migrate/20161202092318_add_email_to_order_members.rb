class AddEmailToOrderMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :order_members, :email, :string
  end
end
