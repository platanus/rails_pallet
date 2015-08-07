class PaperclipUpload::UploadSerializer < ActiveModel::Serializer
  attributes :identifier, :file_extension, :file_name, :download_url
end
