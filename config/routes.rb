Rails.application.routes.draw do
  root 'home#show'

  devise_for :users

  resource :user, only: [:edit, :update]

  get 'users', to: 'users#show', as: :user_profile
end
