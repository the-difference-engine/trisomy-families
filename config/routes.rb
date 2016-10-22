Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/events' => 'events#index'
      post '/events' => 'events#create'

    end
  end

  root 'users#index'

  resources :events

  get '/profile/new' => 'children#new_profile'
  get '/profile/:id' => 'children#show'
  get '/profile/:id/edit' => 'children#edit'
  post '/profile' => 'children#create_profile'
  patch '/profile/:id' => 'children#update'
  patch '/profile/:id/photo' => 'children#update_photo'
  delete '/profile/:id' => 'children#destroy'

  get '/calendar' => 'users#calendar'
end
