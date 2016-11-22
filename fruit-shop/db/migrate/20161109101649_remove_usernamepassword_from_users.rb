class RemoveUsernamepasswordFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :username, :string
    remove_column :users, :password, :string
  end
end
