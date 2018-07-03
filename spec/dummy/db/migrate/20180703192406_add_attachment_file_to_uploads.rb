class AddAttachmentFileToUploads < ActiveRecord::Migration
  def self.up
    change_table :rails_pallet_uploads do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :rails_pallet_uploads, :file
  end
end
