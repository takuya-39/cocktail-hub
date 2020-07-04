Rails.application.routes.draw do
  get 'users/show'
  root to: 'posts#index'

  resources :posts

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }

  devise_scope :user do
    get 'signup', :to => 'users/registrations#new'
    get 'login', :to => 'users/sessions#new'
    get 'logout', :to => 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:show]

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index]
    end
  end
end
