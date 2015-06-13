module PaperclipUpload
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    class_methods do
      def has_attached_upload(_name, _options = {})
        attr_accessor :upload_id
        attr_accessor :upload

        before_save do
          self.upload = PaperclipUpload::Upload.find(self.upload_id) if self.upload_id

          if self.upload
            if !self.upload.is_a? PaperclipUpload::Upload
              raise "invalid PaperclipUpload::Upload instance"
            end

            self.send("#{_name}=", self.upload.file)
            self.upload.destroy
          end
        end

        has_attached_file(_name, _options)
      end
    end
  end
end

ActiveRecord::Base.send(:include, PaperclipUpload::ActiveRecordExtension)
