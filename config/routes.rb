PaperclipUpload::Engine.routes.draw do
  resources :uploads, only: [:create, :show], defaults: { format: :json }
end
