Rails.application.routes.draw do
  devise_for :admins
  namespace :api do
    namespace :v1 do
      resources :events
      resources :family_center
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
  get 'profile/:id/register' => 'children#register'
  post 'profile/:id/register' => 'children#confirm_register'
  delete '/profile/:id' => 'children#destroy'
  post 'profile/:id/background' => 'children#background_history'
  post 'profile/:id/health' => 'children#health_history'

  get '/calendar' => 'users#calendar'

  get '/family-dashboard' => 'families#index'

  get '/family-center' => 'family_center#index'
end
