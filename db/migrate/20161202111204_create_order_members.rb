class CreateOrderMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :order_members do |t|
      t.string :username
      t.string :fullname
      t.string :address
      t.string :phone
      t.string :pay_type
      t.references :user, foreign_key: true
      t.string :status
      t.string :note
      t.string :email
      t.integer :total_price

      t.timestamps
    end
  end
end
