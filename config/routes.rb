Rails.application.routes.draw do
  root 'welcome#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :admin, as: '' do
    get 'dashboard', to: 'dashboard#show'
    resources :projects
    resources :tasks
    resources :companies
  end
end
