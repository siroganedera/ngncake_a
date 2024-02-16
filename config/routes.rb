Rails.application.routes.draw do
  
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root :to => 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    get 'customers/my_page', to: 'customers#show'
    get 'customers/information/edit', to: 'customers#edit'
    patch 'customers/information', to: 'customers#update'
    get 'customers/unsubscribe', to: 'customers#unsubscribe'
    patch 'customers/withdraw', to: 'customers#withdraw'
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
  end

  namespace :admin do
    root :to => 'homes#top'
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :orders_details, only: [:update]
  end

end
