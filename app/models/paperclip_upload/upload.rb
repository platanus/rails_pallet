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
  end
end
