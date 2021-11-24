Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'styleguide', to: 'pages#styleguide'
  resources :comparisons, only: %i[ show new create destroy] do
    member do
      get 'worldmap'
    end
  end
  resources :articles, only: [:index]
  resource :board, only: [:show]
  resources :entries, only: [:destroy]

end
