class RemoveOwnersAddUserIdToSongsAndVideos < ActiveRecord::Migration
  def up
  	remove_column :songs, :owner
    remove_column :videos, :owner
    add_column :songs, :user, :string
    add_column :videos, :user, :string
  end

  def down
  	add_column :songs, :owner, :string
    add_column :videos, :owner, :string
    remove_column :songs, :user
    remove_column :videos, :user
  end
end