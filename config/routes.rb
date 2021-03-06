Rails.application.routes.draw do
  root 'start_page#home'

  get '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  get '/calculator', to: 'users#bmi_calc'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
