class AddResolvedToQueries < ActiveRecord::Migration
  def self.up
  	add_column :queries, :resolved, :boolean, :default => false
  end

  def self.down
  	remove_column :queries, :resolved
  end
end
