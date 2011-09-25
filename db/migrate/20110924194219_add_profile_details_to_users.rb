class AddProfileDetailsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :firstname, :string
  	add_column :users, :lastname, :string
  	add_column :users, :city, :string
  	add_column :users, :country, :string
  	add_column :users, :tvshows, :text
  	add_column :users, :movies, :text
  	add_column :users, :artists, :text
  	add_column :users, :albums, :text
    add_column :users, :liveshows, :text
  end
end
