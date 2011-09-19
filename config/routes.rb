MediaManager::Application.routes.draw do
  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  
  match 'view/:type/:id' => 'view#index'
  match 'play/:type/:id' => 'view#play'
  
  resources :users
  resources :sessions
  resources :songs
  resources :owners

  root :to => "home#index"
end
