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
  get '/profile/:id' => 'children#show'
  get '/profile/:id/edit' => 'children#edit'
  post '/profile' => 'children#create_profile'
  patch '/profile/:id' => 'children#update'
  patch '/profile/:id/photo' => 'children#update_photo'
  get 'profile/:id/register' => 'children#register'
  post 'profile/:id/register' => 'children#confirm_register'
  delete '/profile/:id' => 'children#destroy'
  post 'profile/:id/background' => 'children#background_history'

  get '/calendar' => 'users#calendar'
end
