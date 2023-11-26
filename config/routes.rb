Rails.application.routes.draw do

  get 'users/:id', to: 'users#show', as: :user_profile

  root 'home#show'

  devise_for :users

  resource :friendships
  resource :user, only: [:edit, :update]

  get 'friendship', to: 'friendships#show', as: :friendship
end
