class AddAuthorIdToStatus < ActiveRecord::Migration
  def change
  	add_column :notices, :author_id, :integer
  end
end
