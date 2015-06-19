PaperclipUpload::Engine.routes.draw do
  resources :uploads, only: [:create], defaults: { format: :json }
end
