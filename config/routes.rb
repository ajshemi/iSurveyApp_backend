Rails.application.routes.draw do
  # resources :watson_sentiments
  # resources :watson_emotions
  resources :watson_emotions, only: [:index,:show]#,:create,:destroy]
  resources :watson_sentiments, only: [:index,:show]#,:create,:destroy]
  resources :comments, only: [:index,:show,:update,:destroy,:create]
  resources :reviews, only: [:index,:create,:update,:show,:destroy]
  resources :products, only: [:index]
  
  resources :users, only: [:create,:show]#,:index]

  get 'rating/:id', to: 'reviews#ratingsummary'
  get 'allrating', to: 'reviews#allratingaverage'
  get '/:id/sentiment', to:'watson_sentiments#analyze'
  get '/:id/emotion', to:'watson_emotions#analyze'
  post '/login', to: 'users#login'
  get '/persist', to: 'users#persist' #how does persist work?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
