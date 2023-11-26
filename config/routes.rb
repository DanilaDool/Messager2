Rails.application.routes.draw do
  get 'friends/show'

  get 'users/:id', to: 'users#show', as: :user_profile

  root 'home#show'

  devise_for :users

  resource :friendships, only: [:create]
  patch '/friendships/:id/accept', to: 'friendships#accept', as: 'accept_friendship'
  patch '/friendships/:id/reject', to: 'friendships#reject', as: 'reject_friendship'

  resource :user, only: [:edit, :update]

  get 'friendship', to: 'friendships#show', as: :friendship
end
