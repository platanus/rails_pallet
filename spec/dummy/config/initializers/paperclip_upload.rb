PaperclipUpload.setup do |config|
  # The upload module uses a salt string to generate an unique hash for each instance.
  # A salt string can be defined here to replace the default and increase the module's security.
  # config.hash_salt = "A new and improved string"

  # If true, you will need to pass [host_model_paperclip_attribute_name]_+upload|upload_identifier
  # instead just "upload" or "upload_identifier" to the host model to use an upload resource.
  # config.use_prefix = false
end
