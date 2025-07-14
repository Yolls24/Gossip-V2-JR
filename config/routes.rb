Rails.application.routes.draw do
  root "gossips#index"

  resources :users, only: [:show, :new, :create]

  resources :gossips do
    resources :comments, only: [:create, :destroy, :edit, :update, :show] do
      resource :like, only: [:create, :destroy]
    end
    resource :like, only: [:create, :destroy]
  end

  resources :cities, only: [:show]
  resources :tags, only: [:show]

  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get '/welcome/:first_name', to: 'static_pages#welcome', as: 'welcome'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # 💬 Routes pour la messagerie
  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
end











