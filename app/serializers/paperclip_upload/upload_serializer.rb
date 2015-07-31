class PaperclipUpload::UploadSerializer < ActiveModel::Serializer
  attributes :id, :identifier, :file_extension, :file_name
end
