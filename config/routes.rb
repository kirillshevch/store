Store::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "users/omniauth_callbacks/facebook"

  root "main#index"

  resources :books, only:   [:show]
  resources :billing_addresses,  except: [:index, :destroy]
  resources :shipping_addresses, except: [:index, :destroy]
  resources :credit_cards,       except: [:index, :destroy]
  resources :categories, only: [:index, :show]
  match "shop", to: "category#index",    via: "get"

  resources :order_items,  except: [:edit, :show]
  match "cart", to: "order_items#index", via: "get"

  devise_for :users, controllers: {
                       registrations: "users/registrations",
                       omniauth_callbacks: "users/omniauth_callbacks"
                   }
end