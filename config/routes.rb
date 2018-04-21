Rails.application.routes.draw do
  resources :story_tasks
  root 'welcome#show'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    invitations:   'users/invitations'
  }

  namespace :admin, as: nil do
    get 'dashboard', to: 'dashboard#show'
    get 'profile', to: 'profiles#show', as: :profile
    resources :projects, except: [:index] do
      resources :tags, only: [:index]
      resources :iterations, only: [:update] do
        collection do
          get 'done', to: 'iterations#index'
        end

        member do
          put 'finish', to: 'iterations#finish'
        end
      end
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
    resources :accounts, except: [:show] do
      resources :invitation, only: [:new, :create, :update], controller: 'users/invitations', as: 'user_invitations'
    end
    resources :accounts_users, only: [:destroy]
  end
end
