Circles::Application.routes.draw do
  resources :users do
    resources :friend_circles, only: [:index, :new, :create]
  end

  resources :friend_circles, only: [:show, :destroy]

  resource :session, only: [:new, :create, :destroy]
end
