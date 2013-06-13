class AddAttachmentThumbnailPhotoToGreenroofs < ActiveRecord::Migration
  def self.up
    add_attachment :greenroofs, :photo
    add_attachment :greenroofs, :thumbnail
    change_table :greenroofs do |t|
      t.attachment :thumbnail
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :greenroofs, :photo
    remove_attachment :greenroofs, :thumbnail
    drop_attached_file :greenroofs, :thumbnail
    drop_attached_file :greenroofs, :photo
  end
end
