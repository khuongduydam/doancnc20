class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :pay_type

      t.timestamps
    end
  end
end
