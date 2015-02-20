Store::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "users/omniauth_callbacks/facebook"

  root "main#index"

  resources :addresses, only: [:index, :create]
  resources :books, only: [:show]
  resources :billing_addresses,  only: [:create, :update]
  resources :shipping_addresses, only: [:create, :update]
  resources :credit_cards, except: [:index, :show, :destroy]
  resources :categories, only: [:index, :show]
  match "shop", to: "categories#index",  via: "get"

  resources :order_items, except: [:edit, :show]
  match "cart", to: "order_items#index", via: "get"

  resources :orders, only: [:index, :show, :update]
  match "delivery", to: "orders#delivery", via: "get"
  match "delivery_add", to: "orders#delivery_add", via: "get"
  match "confirm", to: "orders#confirm", via: "get"

  devise_for :users, controllers: {
                       registrations: "users/registrations",
                       sessions: "users/sessions",
                       omniauth_callbacks: "users/omniauth_callbacks"
                   }
end