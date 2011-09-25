class AddPublicHashToUser < ActiveRecord::Migration
  def change
  	add_column :users, :public_token, :string
  end
end
