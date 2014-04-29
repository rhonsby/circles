Circles::Application.routes.draw do
  root to: 'posts#feed'

  resources :users do
    resources :friend_circles, only: [:index]
  end

  # temp posts/show -> feed
  resources :posts, only: [:show, :new, :create]

  resources :friend_circles, except: [:index]

  resource :session, only: [:new, :create, :destroy]

  get '/feed', to: 'posts#feed'
end
