Rails.application.routes.draw do
  devise_for :users

  root 'users#index'

  get '/profile/new' => 'children#new_profile'
  get '/profile/:id' => 'children#show'
  get '/profile/:id/edit' => 'children#edit'
  post '/profile' => 'children#create_profile'
  patch '/profile/:id' => 'children#update'
  patch '/profile/:id/photo' => 'children#update_photo'
  delete '/profile/:id' => 'children#destroy'
end
