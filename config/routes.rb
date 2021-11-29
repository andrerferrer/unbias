Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'styleguide', to: 'pages#styleguide'
  get 'mission', to: 'pages#mission'
  resources :comparisons, only: %i[ show new create update destroy] do
    member do
      get 'worldmap'
    end
    # get 'create-entries', to: 'entries#create_entries'
    post 'create-entries', to: 'entries#create_entries'
    get 'remove-article-one', to: 'entries#remove_article_one'
    get 'remove-article-two', to: 'entries#remove_article_two'
    get 'add-article-one', to: 'entries#add_article_one'
    get 'add-article-two', to: 'entries#add_article_one'
  end

  resource :board, only: [:show]
  resources :entries, only: [:destroy]
end
