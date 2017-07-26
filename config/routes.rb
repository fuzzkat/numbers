Rails.application.routes.draw do
  resources :numbers, only: :index

  root :to => 'numbers#index'
end
