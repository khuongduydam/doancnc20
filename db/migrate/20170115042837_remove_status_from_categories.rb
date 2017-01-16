class RemoveStatusFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :status, :string
  end
end
