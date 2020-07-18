Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :products, only: [:new, :create] do
    resources :production_data, only: :create
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
