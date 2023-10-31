Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :blobs, only: [:create, :show]
    post "user_token" => "blobs#user_token"
  end
end
