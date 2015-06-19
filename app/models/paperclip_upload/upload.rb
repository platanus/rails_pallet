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
    has_attached_file :file, path: ':rails_root/tmp/uploads/:id/:filename'

    do_not_validate_attachment_file_type :file
    validates_attachment_presence :file

    def id_to_hash
      raise "valid with saved instance only" if self.id.blank?
      hashids = Hashids.new(PaperclipUpload.hash_salt)
      hashids.encode(self.id)
    end
  end
end
