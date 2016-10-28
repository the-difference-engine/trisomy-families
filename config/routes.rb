Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/events' => 'events#index'
      post '/events' => 'events#create'

    end
  end

  devise_for :users

  root 'users#index'

  resources :events

  get '/profile/new' => 'children#new_profile'
  post '/profile' => 'children#create_profile'
  get '/profile/:id' => 'children#show'
  get '/profile/:id/edit' => 'children#edit'
  patch '/profile/:id' => 'children#update'
  patch '/profile/:id/photo' => 'children#update_photo'
  delete '/profile/:id' => 'children#destroy'

  get '/calendar' => 'users#calendar'
end