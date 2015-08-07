PaperclipUpload::Engine.routes.draw do
  resources :uploads, only: [:create], defaults: { format: :json }
  get '/uploads/:identifier/download', to: 'uploads#download', as: :download
end
