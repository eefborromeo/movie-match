Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dashboard' => 'dashboard#index'
  get '/search' => 'dashboard#search'
  post '/approve/:id' => 'dashboard#approve'

  root to: "dashboard#index"
end
