# == Schema Information
#
# Table name: paperclip_upload_uploads
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

module PaperclipUpload
  class Upload < ActiveRecord::Base
    IDENTIFIER_LENGTH = 8

    has_attached_file :file, path: ':rails_root/tmp/uploads/:id/:filename'

    do_not_validate_attachment_file_type :file
    validates_attachment_presence :file

    def identifier
      raise "valid with saved instance only" if self.id.blank?
      self.class.hashid.encode(self.id)
    end

    def self.identifier_to_id(_identifier)
      self.hashid.decode(_identifier).first
    end

    private

    def self.hashid
      Hashids.new(PaperclipUpload.hash_salt, IDENTIFIER_LENGTH)
    end
  end
end
