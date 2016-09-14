Rails.application.routes.draw do
  root 'repositories#index'
  resources :repositories do
    member do
      put :total_downloads
      put :hide
    end
    collection do
      get :search
  	end
  end
  resources :users
  get "/auth/:provider/callback" => "callbacks#create"
  get "/repositories/:id/favourite" => "repositories#favourite", :as => :repositories_favourite
  delete "/signout" => "callbacks#destroy", :as => :signout
end
