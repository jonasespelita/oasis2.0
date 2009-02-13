class AddIdnoToViolations < ActiveRecord::Migration
  def self.up
    add_column :violations, :idno, :string
  end

  def self.down
    remove_column :violations, :idno
  end
end
