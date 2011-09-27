class RemoveModelOverlapFromSongs < ActiveRecord::Migration
  def up
  	remove_column :songs, :user
    remove_column :songs, :filename
    remove_column :songs, :artist
    remove_column :songs, :album
  end

  def down
    add_column :songs, :user, :string
    add_column :songs, :filename, :string
    add_column :songs, :artist, :string
    add_column :songs, :album, :string
  end
end
