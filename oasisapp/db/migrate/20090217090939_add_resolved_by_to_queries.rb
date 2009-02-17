class AddResolvedByToQueries < ActiveRecord::Migration
  def self.up
  	add_column :queries, :resolved_by, :integer
  end

  def self.down
  	remove_column :queries, :resolved_by
  end
end
