Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :products, only: [:new, :create, :show] do
    collection do
      get "search"
    end
    resources :production_data, only: :create
    resources :inspection_data, only: :create
    resources :evaluation_data, only: :create
  end
end
