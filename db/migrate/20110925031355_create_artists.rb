class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :start
      t.string :end
      t.text :bio
      t.string :public_token

      t.timestamps
    end
  end
end
