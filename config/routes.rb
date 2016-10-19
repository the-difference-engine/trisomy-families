Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/events' => 'events#index'

    end
  end

  devise_for :users

  root 'users#index'

  get '/profile/new' => 'users#new_profile'
  post '/profile' => 'users#create_profile'

  resources :events

  get '/profile/new' => 'children#new_profile'
  post '/profile' => 'children#create_profile'

  get '/calendar' => 'users#calendar'

end
