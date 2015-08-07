Rails.application.routes.draw do
  post "api/uploads", to: "api/uploads#create", defaults: { format: :json }
  get "api/uploads/:identifier/download", to: "api/uploads#download", defaults: { format: :json }, as: :download_api_upload

  mount PaperclipUpload::Engine => '/'
end
