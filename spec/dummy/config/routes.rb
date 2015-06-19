Rails.application.routes.draw do
  mount PaperclipUpload::Engine => '/'
  PaperclipUpload.draw_additional_upload_endpoints(self)
end
