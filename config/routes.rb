Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users
=======
  get '/' => 'pages#index'

>>>>>>> 7e078aa92241530d5308fb42fb6bcbdc0c9f6229
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'users#index'

end
