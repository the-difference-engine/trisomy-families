Rails.application.routes.draw do
  devise_for :users

  root 'users#index'

  get '/profile/new' => 'children#new_profile'
  get '/profile/:id' => 'children#show'
  post '/profile' => 'children#create_profile'
  patch '/profile/:id' => 'children#update'
end
