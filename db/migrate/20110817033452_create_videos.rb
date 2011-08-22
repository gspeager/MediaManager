class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :filename
      t.string :title
      t.boolean :isTV
      t.string :series
      t.integer :episode
      t.integer :season
      t.string :year
      t.string :length
      t.string :owner
      t.float :rating
      t.string :director
      t.string :actors
      t.integer :playcount
      t.string :lastplay
      t.string :thumbnail
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
