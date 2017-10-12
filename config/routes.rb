Rails.application.routes.draw do
  get 'users/new'

  root 'start_page#home'

  get '/signup',  to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
