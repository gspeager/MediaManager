class CreateOwners < ActiveRecord::Migration
  def self.up
    create_table :owners do |t|
      t.string :ownerName

      t.timestamps
    end
  end

  def self.down
    drop_table :owners
  end
end
