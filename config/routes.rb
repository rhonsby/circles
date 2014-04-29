Circles::Application.routes.draw do
  root to: 'posts#feed'

  resources :users

  # temp posts/show -> feed
  resources :posts, only: [:show, :new, :create]

  resources :friend_circles

  resource :session, only: [:new, :create, :destroy]

  get '/feed', to: 'posts#feed'
end
