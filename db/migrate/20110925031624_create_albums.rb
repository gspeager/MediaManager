class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :year
      t.string :public_token
      t.text :notes

      t.timestamps
    end
  end
end
