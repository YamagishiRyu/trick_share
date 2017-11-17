Rails.application.routes.draw do

  root :to => redirect('static_page/help')

  # static page
  get 'static_page/help', to: 'static_page#help'
  get 'static_page/contact', to: 'static_page#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
