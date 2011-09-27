class ChangeUserIdAndAddHashToSongs < ActiveRecord::Migration
  def up
  	remove_column :songs, :user_id
  	add_column :songs, :user_id, :integer
  	add_column :songs, :public_token, :string
  end

  def down
  	remove_column :songs, :user_id
  	remove_column :songs, :public_token
  	add_column :songs, :user_id, :string
  end
end
