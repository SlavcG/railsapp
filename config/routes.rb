Rails.application.routes.draw do
  resources :products
  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/index'

  get 'static_pages/landing_page'

  root 'products#index'

  post 'static_pages/thank_you'

  resources :orders, only: [:index, :show, :create, :destroy]
end
