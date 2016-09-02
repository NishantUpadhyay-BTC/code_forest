Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'repositories#index'
  resources :repositories

  get "/auth/:provider/callback" => "callbacks#create"
  get "users/index" => "users#index"
  delete "/signout" => "callbacks#destroy", :as => :signout
end
