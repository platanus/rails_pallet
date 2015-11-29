# == Schema Information
#
# Table name: rails_pallet_uploads
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

module RailsPallet
  class Upload < ActiveRecord::Base
    IDENTIFIER_LENGTH = 8

    has_attached_file :file,
      path: ':rails_root/public/uploads/:identifier/:filename',
      url: "/uploads/:identifier/:basename.:extension"

    do_not_validate_attachment_file_type :file
    validates_attachment_presence :file

    def identifier
      raise "valid with saved instance only" if id.blank?
      self.class.hashid.encode(id)
    end

    def file_extension
      return unless file.exists?
      File.extname(file.original_filename).split('.').last
    end

    def file_name
      return unless file.exists?
      file_file_name.gsub(".#{file_extension}", "")
    end

    def self.find_by_identifier(_identifier)
      decoded_id = identifier_to_id(_identifier)
      RailsPallet::Upload.find(decoded_id)
    end

    def download_url
      file.url
    end

    def self.hashid
      Hashids.new(RailsPallet.hash_salt, IDENTIFIER_LENGTH)
    end

    def self.identifier_to_id(_identifier)
      hashid.decode(_identifier).first
    end

    Paperclip.interpolates(:identifier) do |attachment, _|
      attachment.instance.identifier
    end
  end
end
