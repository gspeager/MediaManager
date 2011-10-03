MediaManager::Application.routes.draw do
  get "signup" => "users#new", :as => "signup"
  get "home" => "users#home", :as => "home"
  get "edit" => "users#edit", :as => "edit"
  match 'profile/:id' => 'users#view'
  match 'artist/:id' => 'artists#view'
  
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  
  match 'view/:type/:id' => 'view#index'
  match 'play/:type/:id' => 'view#play'
  
  resources :users do
    resources :notices
  end
  resources :sessions
  resources :songs
  resources :password_resets

  root :to => "home#index"
end
