Rails.application.routes.draw do
  root 'fruits#index'
  resources :customers, except: [:show, :index, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :fruits, product: 'Fruit', only: :index do
    resources :checkouts,  only: [:new, :create, :show]
  end
end
