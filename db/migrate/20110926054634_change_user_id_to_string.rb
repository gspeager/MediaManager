class ChangeUserIdToString < ActiveRecord::Migration
  def up
  	remove_column :songs, :user_id
  	add_column :songs, :user_id, :string
  end

  def down
  	remove_column :songs, :user_id
  	add_column :songs, :user_id, :integer
  end
end
