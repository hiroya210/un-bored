Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home' # our landing page with the animation
  resources :games, only: [:index]
  resources :users, only: [:update]
  get '/join_instance', to: 'players#join_instance'
  get '/edit_nickname_host', to: 'players#edit_nickname_host'
  resources :instances, only: [:create, :show, :update, :destroy] do
    resources :players, only: [:destroy]
    member do
      get '/edit_nickname_player', to: 'players#edit_nickname_player'
      get '/create_players', to: 'players#create_players'
    end
    resources :rounds, only: [:create, :show] do
      resources :player_inputs, only: [:create]
    end
    resources :votes, only: [:create, :new]
    member do
      get 'redirect_to_vote', to: 'votes#redirect_to_vote'
    end
    resources :results, only: [:show]
  end
  post 'screenshot', to: 'screenshots#save'
end
