class AddAttachmentFileToUploads < ActiveRecord::Migration
  def self.up
    change_table :paperclip_upload_uploads do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :paperclip_upload_uploads, :file
  end
end
