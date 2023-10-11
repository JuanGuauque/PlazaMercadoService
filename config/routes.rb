Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/comprar', to: 'plaza_mercado#comprar'
  get '/historial', to: 'plaza_mercado#historial'
end
