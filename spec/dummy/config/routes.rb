Rails.application.routes.draw do
  post "api/uploads", to: "api/uploads#create", defaults: { format: :json }
  get "api/uploads/:id/download", to: "api/uploads#download", defaults: { format: :json }, as: :api_uploads_download

  mount PaperclipUpload::Engine => '/'
end
