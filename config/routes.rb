Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy', as: :logout
    delete '/logout', to: 'devise/sessions#destroy'
  end

  get 'friends/show'

  get 'users/:id', to: 'users#show', as: :user_profile

  root 'home#show'

  resources :friendships, only: [:create, :update, :destroy] do
    member do
      patch :accept
      patch :reject
    end
  end

  resource :user, only: [:edit, :update]

  get 'friendship_status', to: 'friendships#show', as: :friendship_status
  get 'friends', to: 'friends#show', as: :friend
  get 'friend_show', to: 'friends#index', as: :friend_show
end
