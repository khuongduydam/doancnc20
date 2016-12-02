class AddNoteToOrderMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :order_members, :note, :text
  end
end
