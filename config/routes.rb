Rails.application.routes.draw do
  root to: 'posts#index'

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :posts, only: [:index]
    end
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }

  devise_scope :user do
    resources :users
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:show] do
    member do
      get :user_show_posts, :followings, :followers
    end
  end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index]
    end
  end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :rankings, only: [:index]
    end
  end

  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    resources :users, only: [:index]
    resources :posts, only: [:index]
  end
end
