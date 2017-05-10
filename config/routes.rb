Rails.application.routes.draw do
  resources :projects
  devise_for :users
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
