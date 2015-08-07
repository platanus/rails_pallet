module PaperclipUpload
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    class_methods do
      def has_attached_upload(_paperclip_attr_name, _options = {})
        load_upload_options(_options)
        upload_identifier_attr_name = build_upload_attr_name(_paperclip_attr_name, "identifier")
        upload_attr_name = build_upload_attr_name(_paperclip_attr_name)

        attr_accessor upload_identifier_attr_name, upload_attr_name

        before_validation do
          identifier = self.send(upload_identifier_attr_name)

          if identifier
            found_upload = PaperclipUpload::Upload.find_by_identifier(identifier)
            self.send("#{upload_attr_name}=", found_upload)
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

      private

      def build_upload_attr_name(_paperclip_attr_name, _sufix = nil)
        prefix = !!upload_options.fetch(:use_prefix, PaperclipUpload.use_prefix) ? _paperclip_attr_name : nil
        upload_attr_name = [prefix, ["upload", _sufix].compact.join("_")].compact.join("_")
        raise "you are trying to redefine #{upload_attr_name} attribute" if self.method_defined?(upload_attr_name)
        upload_attr_name
      end

      def load_upload_options(_options = {})
        @upload_options = _options.fetch(:upload, {})
      end

      def upload_options
        @upload_options ||= {}
      end
    end
  end
end

ActiveRecord::Base.send(:include, PaperclipUpload::ActiveRecordExtension)
