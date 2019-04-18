Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepages#index"

  resources :drivers
  resources :passengers do
    resources :trips, only: [:index, :create]
  end
  resources :trips, only: [:edit, :show]
  resources :passengers

  patch "drivers/:id/toggle_available", to: "drivers#toggle_available", as: "toggle_available"
end
