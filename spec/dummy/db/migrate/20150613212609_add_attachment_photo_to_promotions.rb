class AddAttachmentPhotoToPromotions < ActiveRecord::Migration
  def self.up
    change_table :promotions do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :promotions, :photo
  end
end
