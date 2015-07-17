class AddAttachmentPrefixedFileTwoToPromotions < ActiveRecord::Migration
  def self.up
    change_table :promotions do |t|
      t.attachment :prefixed_file_two
    end
  end

  def self.down
    remove_attachment :promotions, :prefixed_file_two
  end
end
