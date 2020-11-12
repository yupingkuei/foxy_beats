Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :vinyls do
    resources :rentals, only: [:new, :create]
  end
  resources :rentals, only: :update
  get '/vinyls/select', to: 'vinyls#select', as: :select_vinyl
  get '/dashboard', to: 'users#dashboard', as: :dashboard
end
