Rails.application.routes.draw do
  devise_for :admins
  namespace :api do
    namespace :v1 do
      resources :events
      resources :search
      get '/children' => 'children#index'
      get '/children/trisomy_type_totals' => 'children#trisomy_type_totals'
      get '/children/birth_order_totals' => 'children#birth_order_totals'
      get '/users' => 'users#index'
      patch '/users' => 'users#update'
      patch '/children' => 'children#update'
      delete '/users/:id' => 'users#destroy'

      get '/birthdays' => 'birthdays#index'
      get '/families' => 'families#index'
      get '/families/children' => 'families#children'
      get '/resources' => 'resources#index'
    end
  end

  devise_for :users

  root 'users#home'
  get 'children-index' => 'users#children_index'
  get 'admin-dashboard' => 'users#index'
  patch 'admin-dashboard' => 'users#update'

  resources :events

  get '/queries' => 'users#query_table'

  get '/resources' => 'resources#index'
  get '/resources/new' => 'resources#new'
  post '/resources' => 'resources#create'
  get '/resources/:id/edit' => 'resources#edit'
  patch '/resources/:id' => 'resources#update'
  delete '/resources/:id' => 'resources#destroy'

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

  # NEW ROUTES FOR CHILD REGISTRATION:
  get 'registrations' => 'registrations#index'
  get 'registrations/:id' => 'registrations#show'
  get 'registrations/:id' => 'registrations#destroy'

  get 'registrations/contact_info/new' => 'contact_info_forms#new'
  post 'registrations/contact_info' => 'contact_info_forms#create'
  get 'registrations/contact_info/:id' => 'contact_info_forms#show'
  get 'registrations/contact_info/:id/edit' => 'contact_info_forms#edit'
  patch 'registrations/contact_info/:id' => 'contact_info_forms#update'
  
  get 'registrations/background_history/new' => 'background_history_forms#new'
  post 'registrations/background_history' => 'background_history_forms#create'
  get 'registrations/background_history/:id' => 'background_history_forms#show'
  get 'registrations/background_history/:id/edit' => 'background_history_forms#edit'
  patch 'registrations/background_history/:id' => 'background_history_forms#update'

  
  get 'registrations/health_history/new' => 'health_history_forms#new'
  post 'registrations/health_history' => 'health_history_forms#create'
  get 'registrations/health_history/:id' => 'health_history_forms#show'
  get 'registrations/health_history/:id/edit' => 'health_history_forms#edit'  
  patch 'registrations/health_history/:id' => 'health_history_forms#update'

  # OLD ROUTES FOR CHILD REGISTRATION:
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

  get 'data-center' => 'professional_center#index'

end
