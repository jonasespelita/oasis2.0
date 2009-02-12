class AddQueryFk < ActiveRecord::Migration
  def self.up
  		execute "ALTER TABLE queries ADD CONSTRAINT fk_queries_to_users FOREIGN KEY (user_id) REFERENCES users (id);"
  end

  def self.down
  		execute "ALTER TABLE queries DROP CONSTRAINT fk_queries_to_users;"
  end
end
