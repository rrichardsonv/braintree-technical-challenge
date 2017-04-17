Rails.application.routes.draw do
  root 'fruits#index'
  resources :fruits, product: 'Fruit', only: :index do
    resources :checkouts,  only: [:new, :create, :show]
  end
end
