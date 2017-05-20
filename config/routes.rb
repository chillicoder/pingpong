Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :games
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'
end
