Rails.application.routes.draw do
  get 'users/new'
root 'repositories#index'
  root to: "users#new"
  get "/auth/:provider/callback" => "callbacks#create"
  delete "/signout" => "callbacks#destroy", :as => :signout
end
