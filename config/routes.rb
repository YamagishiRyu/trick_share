Rails.application.routes.draw do

  root :to => redirect('/help')

  # static page
  get '/help', to: 'static_page#help'
  get '/contact', to: 'static_page#contact'

  # contributors
  get '/signup', to: 'contributors#new'
  post '/signup', to: 'contributors#create'
  resources :contributors

  # sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
