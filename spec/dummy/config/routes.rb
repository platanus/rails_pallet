Rails.application.routes.draw do
  post "api/uploads", to: "api/uploads#create", defaults: { format: :json }

  mount RailsPallet::Engine => '/'
end
