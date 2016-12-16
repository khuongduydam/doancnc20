class ChangeDataTypeOfNoteFromOrderMembers < ActiveRecord::Migration[5.0]
  def up
    change_column :order_members, :note, :text
  end

  def down
    change_column :order_members, :note, :string
  end
end
