Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  devise_scope :user do
    post "users/production_guest_sign_in", to: "users/sessions#new_production_guest"
  end
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
