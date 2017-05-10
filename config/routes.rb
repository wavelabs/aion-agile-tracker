Rails.application.routes.draw do
  root 'welcome#show'

  resources :projects
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
