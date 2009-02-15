class CreateCurOnlines < ActiveRecord::Migration
  def self.up
    create_table :cur_onlines do |t|
    	t.timestamp :date
    	t.string :name
    	t.string :position

      t.timestamps
    end
  end

  def self.down
    drop_table :cur_onlines
  end
end
