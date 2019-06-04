Rails.application.routes.draw do
  get 'about', to: 'pages#about', as: 'about'
  get 'submit', to: 'pages#submit', as: 'submit'

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "pages#index"

  resources :games do
    resources :screenshots
  end

  resources :tags
end
