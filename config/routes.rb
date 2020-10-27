Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  devise_scope :user do
    post "users/production_guest_sign_in", to: "users/sessions#new_production_guest"
    post "users/sales_guest_sign_in", to: "users/sessions#new_sales_guest"
    post "users/change_to_production_guest", to: "users/sessions#change_to_production_guest"
    post "users/change_to_sales_guest", to: "users/sessions#change_to_sales_guest"
  end
  root "products#index"
  resources :products do
    collection do
      get "search"
    end
    resources :production_data, only: [:create, :update]
    resources :inspection_data, only: [:create, :update]
    resources :evaluation_data, only: [:create, :update]
  end
end
