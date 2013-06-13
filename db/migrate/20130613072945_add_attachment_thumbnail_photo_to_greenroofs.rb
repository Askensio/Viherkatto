class AddAttachmentThumbnailPhotoToGreenroofs < ActiveRecord::Migration
  def change
    change_table :greenroofs do |t|
      t.attachment :photo
    end
  end
end
