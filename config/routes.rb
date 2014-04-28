Circles::Application.routes.draw do
  resources :users do
    resources :friend_circles, only: [:index]
  end

  # temp posts/show -> feed
  resources :posts, only: [:show, :new, :create]

  resources :friend_circles, only: [:show, :destroy, :new, :create]

  resource :session, only: [:new, :create, :destroy]
end
