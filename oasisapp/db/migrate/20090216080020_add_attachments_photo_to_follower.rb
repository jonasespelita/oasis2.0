class AddAttachmentsPhotoToFollower < ActiveRecord::Migration
  def self.up
    add_column :followers, :photo_file_name, :string
    add_column :followers, :photo_content_type, :string
    add_column :followers, :photo_file_size, :integer
    add_column :followers, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :followers, :photo_file_name
    remove_column :followers, :photo_content_type
    remove_column :followers, :photo_file_size
    remove_column :followers, :photo_updated_at
  end
end
