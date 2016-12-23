class AddColumnStatusToCategoryProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :status, :string
    add_column :products, :status, :string
  end
end
