class AddCurLoginToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :cur_login, :datetime
  end

  def self.down
    remove_column :users, :cur_login
  end
end
