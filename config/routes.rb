Rails.application.routes.draw do

  # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # URL /admin/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root :to => 'public/homes#top'
  get 'about' => 'public/home#about'

  resources :items, only: [:index, :show]

  get 'customers/my_page', to: 'customers#show'
  get 'customers/information/edit', to: 'customers#edit'
  get 'customers/information', to: 'customers#update'
  get 'customers/unsubscribe', to: 'customeres#unsubscribe'
  delete 'customers/withdraw', to: 'customers#withdraw'

  resources :cart_items, only: [:create, :index, :update, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end

  resources :orders, only: [:new, :create, :index, :show] do
    collection do
      post 'confirm'
      get 'thanks'
    end
  end

  resources :addresses, only: [:create, :index, :edit, :update, :destroy]

  namespace :admin do
    root :to => 'homes#top'
  end

  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
  end

  namespace :admin do
    resources :genres, only: [:create, :index, :edit, :update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :orders, only: [:show, :update]
  end
  namespace :admin do
    resources :orders_details, only: [:update]
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
