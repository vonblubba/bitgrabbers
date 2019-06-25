Rails.application.routes.draw do
  get 'about', to: 'pages#about', as: 'about'
  get 'submit', to: 'pages#submit', as: 'submit'
  get 'search', to: 'pages#search', as: 'search'
  get 'robots', to: 'pages#robots', as: 'robots'
  get 'rss', to: 'rss#index', as: 'rss_feed'

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "pages#index"

  resources :games, only: [:index, :show] do
    resources :screenshots, only: [:show]
  end

  resources :screenshots, only: [:index]

  resources :tags, only: [:show]
  resources :submissions, only: [:create]
end
