Rails.application.routes.draw do
  root to: 'teams#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :teams, only: [:create, :destroy]
  resources :channels, only: [:show, :create, :destroy]
  resources :talks, only: [:show]
  resources :team_users, only: [:create, :destroy]

  get '/:slug', to: 'teams#show'

  mount ActionCable.server => '/cable'
end
