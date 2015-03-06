Store::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "users/omniauth_callbacks/facebook"

  root "main#index"

  resources :checkouts
  resources :addresses, except: [:index, :destroy]
  resources :books, only: [:show] do
    resource :review, only: [:new, :create]
  end
  resources :billing_addresses,  only: [:create, :update]
  resources :shipping_addresses, only: [:new, :create, :edit, :update]
  resources :credit_cards, except: [:index, :show, :destroy]
  resources :categories, only: [:index, :show]
  get "shop", to: "categories#index"

  resources :order_items, except: [:edit, :show]
  get "cart", to: "order_items#index"

  resources :orders, only: [:index, :show, :update]
  get "delivery", to: "orders#delivery"
  get "delivery_add", to: "orders#delivery_add"
  get "confirm", to: "orders#confirm"

  devise_for :users, controllers: {
                       registrations: "users/registrations",
                       sessions: "users/sessions",
                       omniauth_callbacks: "users/omniauth_callbacks"
                   }
end