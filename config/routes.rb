Rails.application.routes.draw do
  get 'pages/index'
  get 'pages/about'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "pages#index"
end
