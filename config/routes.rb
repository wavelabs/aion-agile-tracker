Rails.application.routes.draw do
  root 'welcome#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :admin, as: '' do
    get 'dashboard', to: 'dashboard#show'
    get ':id/profile', to: 'profiles#show', as: :user_profile
    get 'profile', to: 'profiles#show', as: :profile
    resources :projects
    resources :tasks
    resources :companies
    resources :companies_users, only: [:destroy]
  end
end
