class AddPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image_name, :string
    add_column :users, :password_digest, :string
    remove_column :users, :email, :string
  end
end
