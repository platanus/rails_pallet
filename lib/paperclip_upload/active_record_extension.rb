module PaperclipUpload
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    class_methods do
      def has_attached_upload(_paperclip_attr_name, _options = {})
        upload_identifier_attr_name = "#{_paperclip_attr_name}_upload_identifier"
        upload_attr_name = "#{_paperclip_attr_name}_upload"
        attr_accessor upload_identifier_attr_name, upload_attr_name

        before_validation do
          upload_identifier = self.send(upload_identifier_attr_name)

          if upload_identifier
            decoded_id = PaperclipUpload::Upload.identifier_to_id(upload_identifier)
            self.send("#{upload_attr_name}=", PaperclipUpload::Upload.find(decoded_id))
          end

          upload_object = self.send(upload_attr_name)

          if upload_object
            raise "invalid PaperclipUpload::Upload instance" if !upload_object.is_a?(PaperclipUpload::Upload)
            self.send("#{_paperclip_attr_name}=", upload_object.file)
            upload_object.destroy
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
