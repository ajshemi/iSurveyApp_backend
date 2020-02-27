Rails.application.routes.draw do
  resources :comments, only: [:index,:show,:update,:destroy,:create]
  resources :reviews, only: [:index,:create,:update,:show]
  resources :products, only: [:index]
  resources :users, only: [:create,:show,:index]


  post '/login', to: 'users#login'
  get '/persist', to: 'users#persist' #how does persist work?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
