class CreateOrderMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :order_members do |t|
      t.string :username
      t.string :full_name
      t.string :address
      t.string :phone
      t.string :pay_type
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
