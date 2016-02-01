Rails.application.routes.draw do
  resources :line_items
  resources :carts
  get 'store/index'

  resources :products
  root 'store#index', as: 'store'
  
  resources :line_items do
    #member do
    #  put 'decrement'
    #end
    put 'decrement', on: :member
  end
end
