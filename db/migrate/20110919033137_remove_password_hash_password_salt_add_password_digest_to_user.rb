class RemovePasswordHashPasswordSaltAddPasswordDigestToUser < ActiveRecord::Migration
  def up
    remove_column :users, :password_hash
    remove_column :users, :password_salt
    add_column :users, :password_digest, :string
  end

  def down
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    remove_column :users, :password_digest
  end
end
