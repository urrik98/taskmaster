Rails.application.routes.draw do

  resources :lists do
    resources :todos
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'lists#index'
end
