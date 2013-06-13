class AddAttachmentThumbnailPhotoToGreenroofs < ActiveRecord::Migration
  def self.up
    change_table :greenroofs do |t|
      t.attachment :thumbnail
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :greenroofs, :thumbnail
    drop_attached_file :greenroofs, :photo
  end
end
