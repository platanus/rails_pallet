PaperclipUpload.setup do |config|
  # By default, you have the /uploads endpoint to create new upload resources.
  # you can pass additional endpoints like this:
  # config.additional_upload_endpoints = ["/api/uploads", "/attachments"]

  # The upload module uses a salt string to generate an unique hash for each instance.
  # A salt string can be defined here to replace the default and increase the module's security.
  # config.hash_salt = "A new and improved string"
end
