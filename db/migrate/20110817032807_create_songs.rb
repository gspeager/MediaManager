class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :filename
      t.string :title
      t.string :artist
      t.string :album
      t.string :length
      t.integer :tracknumber
      t.string :year
      t.string :genre
      t.string :owner
      t.string :albumart
      t.float :rating
      t.integer :playcount
      t.string :lastplay
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :songs
  end
end
