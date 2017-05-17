Rails.application.routes.draw do
  devise_for :admins
  namespace :api do
    namespace :v1 do
      resources :events
      resources :search
      get '/children' => 'children#index'
      get '/children/trisomy_type_totals' => 'children#trisomy_type_totals'
      get '/users' => 'users#index'
      patch '/users' => 'users#update'
      patch '/children' => 'children#update'
      delete '/users/:id' => 'users#destroy'
    end
  end

  devise_for :users

  root 'users#home'
  get 'children-index' => 'users#children_index'
  get 'admin-dashboard' => 'users#index'
  patch 'admin-dashboard' => 'users#update'

  resources :events

  get '/queries' => 'users#query_table'

  get '/family-dashboard' => 'families#index'
  post '/families' => 'families#create'
  get '/families/new' => 'families#new'
  get '/families/:id' => 'families#show'  
  get '/families/:id/edit' => 'families#edit'
  patch '/families/:id' => 'families#update'

  post '/physicians' => 'physicians#create'
  get '/physicians/new' => 'physicians#new'
  get '/physicians/:id' => 'physicians#show'
  get '/physicians/:id/edit' => 'physicians#edit'
  patch '/physicians/:id' => 'physicians#update'
  
  patch '/physicians/:id/photo' => 'physicians#update_photo'

  get '/profile/new' => 'children#new'
  post '/profile' => 'children#create'
  get '/profile/:id' => 'children#show'
  get '/profile/:id/edit' => 'children#edit'
  patch '/profile/:id' => 'children#update'

  patch '/profile/:id/photo' => 'children#update_photo'

  get 'profile/:id/register' => 'children#register'
  post 'profile/:id/register' => 'children#confirm_register'
  get 'profile/:id/edit_registration' => 'children#edit_registration'
  
  get 'profile/:id/edit_background_history' => 'children#edit_background_history'
  get 'profile/:id/edit_health_history' => 'children#edit_health_history'
  delete '/profile/:id' => 'children#destroy'
  get 'profile/:id/background' => 'children#add_background'
  get 'profile/:id/health_history' => 'children#add_health_history'
  post 'profile/:id/background' => 'children#background_history'
  post 'profile/:id/health' => 'children#health_history'
  patch 'profile/:id/register' => 'children#update_registration'
  patch 'profile/:id/health' => 'children#update_health_history'
  patch 'profile/:id/background' => 'children#update_background_history'

  get '/calendar' => 'users#calendar'

  get '/family-center' => 'family_center#index'

  get 'professional-center' => 'professional_center#index'

end
