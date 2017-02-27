Rails.application.routes.draw do

  get 'orphans/index'

  patch 'orphans/update'

  resources :lists do
    resources :todos
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'lists#index'
end
