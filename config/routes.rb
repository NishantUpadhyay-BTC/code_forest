Rails.application.routes.draw do
  get 'users/new'

  root to: "users#new"
  get "/auth/:provider/callback" => "callbacks#create"
  get "/index" => "users#index"
  delete "/signout" => "callbacks#destroy", :as => :signout
end
