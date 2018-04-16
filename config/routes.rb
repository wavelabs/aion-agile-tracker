Rails.application.routes.draw do
  resources :story_tasks
  root 'welcome#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :admin, as: nil do
    get 'dashboard', to: 'dashboard#show'
    get ':id/profile', to: 'profiles#show', as: :user_profile
    get 'profile', to: 'profiles#show', as: :profile
    resources :projects do
      resources :stories do
        resources :comments, only: [:create, :update]

        member do
          patch :estimate, to: 'estimations#update'
          Story.aasm.events.map(&:name).each do |event|
            patch event, to: "stories_states##{event}"
          end
        end
      end
    end
    resources :tasks
    resources :accounts
    resources :accounts_users, only: [:destroy]
  end
end
