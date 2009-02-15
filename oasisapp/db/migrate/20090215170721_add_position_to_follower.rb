class AddPositionToFollower < ActiveRecord::Migration
  def self.up
    add_column :followers, :position, :integer
  end

  def self.down
    remove_column :followers, :position
  end
end
