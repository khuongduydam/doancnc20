class CreateGiftcodes < ActiveRecord::Migration[5.0]
  def change
    create_table :giftcodes do |t|
      t.string :gift_code

      t.timestamps
    end
  end
end
