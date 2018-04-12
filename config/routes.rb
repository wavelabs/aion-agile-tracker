Rails.application.routes.draw do
  resources :story_tasks
  resources :groups
  root 'welcome#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :admin, as: '' do
    get 'dashboard', to: 'dashboard#show'
    get ':id/profile', to: 'profiles#show', as: :user_profile
    get 'profile', to: 'profiles#show', as: :profile
    resources :projects do
      resources :story_types
      resources :story_states
      resources :stories do
        resources :comments, only: [:create, :update]
      end
    end
    resources :tasks
    resources :companies
    resources :companies_users, only: [:destroy]
  end
end
