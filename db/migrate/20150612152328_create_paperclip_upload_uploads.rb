class CreatePaperclipUploadUploads < ActiveRecord::Migration
  def change
    create_table :paperclip_upload_uploads do |t|
      t.timestamps null: false
    end
  end
end
