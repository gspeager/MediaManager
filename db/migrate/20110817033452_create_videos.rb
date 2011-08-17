class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :filename
      t.string :title
      t.bool :isTV
      t.string :series
      t.number :episode
      t.number :season
      t.string :year
      t.string :length
      t.string :owner
      t.number :rating
      t.string :director
      t.string :actors
      t.number :playcount
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
