PaperclipUpload::Engine.routes.draw do
  resources :uploads, only: [:create], defaults: { format: :json } do
    get 'download', on: :member
  end
end
