module PaperclipUpload
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    class_methods do
      def has_attached_upload(_paperclip_attr_name, _options = {})
        attr_accessor :upload_identifier
        attr_accessor :upload

        before_validation do
          if self.upload_identifier
            decoded_id = PaperclipUpload::Upload.identifier_to_id(self.upload_identifier)
            self.upload = PaperclipUpload::Upload.find(decoded_id)
          end

          if self.upload
            if !self.upload.is_a? PaperclipUpload::Upload
              raise "invalid PaperclipUpload::Upload instance"
            end

            self.send("#{_paperclip_attr_name}=", self.upload.file)
            self.upload.destroy
          end
        end

        has_attached_file(_paperclip_attr_name, _options)
      end

      def allow_encoded_file_for(_paperclip_attr_name)
        encoded_attr_name = "encoded_#{_paperclip_attr_name}"
        attr_accessor encoded_attr_name

        before_validation do
          encoded_attr = self.send(encoded_attr_name)
          StringIO.open(Base64.decode64(encoded_attr)) do |data|
            self.send("#{_paperclip_attr_name}=", data)
          end if encoded_attr
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, PaperclipUpload::ActiveRecordExtension)
