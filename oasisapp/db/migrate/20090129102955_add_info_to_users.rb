class AddInfoToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :last_name, :string
  	add_column :users, :first_name, :string
  	add_column :users, :middle_name, :string
  	add_column :users, :number_of_wards, :integer, :default => 0
  	add_column :users, :status, :string
  end

  def self.down
  	remove_column :users, :last_name
  	remove_column :users, :first_name
  	remove_column :users, :middle_name
  	remove_column :users, :number_of_wards
  	remove_column :users, :status
  end
end
