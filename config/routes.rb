Rails.application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users
  end
  resources :roles
  get 'orphans/index'

  patch 'orphans/update'

  resources :lists do
    resources :todos
  end

  authenticated :user do
    root :to => 'lists#index', as: :authenticated_root
  end

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

end
