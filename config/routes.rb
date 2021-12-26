Rails.application.routes.draw do
  namespace :admin do
    get 'order_real_estates/index'
    get 'order_real_estates/show'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/new'
  end
  root 'public/homes#top'
  resources :addresses

  #管理者
  devise_for :admin, skip: [:passwords] ,controllers: {
    sessions: 'admin/sessions',
  }
   #会員
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }
  
  namespace :admin do
    get 'admin/new', to: 'admin/sessions#new'
      resources :customers do
      resources :relationships, only: [:create, :destroy] do
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
        get 'matchers' => 'relationships#matchers', as: 'matchers'
        end
      collection do
        get 'customers/leave' => 'customers#leave'
        patch 'customers/out' => 'customers#out'
      end
    end
    resources :contacts, only: [:new, :create] do
      post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
      post 'contacts/back', to: 'contacts#back', as: 'back'
      get 'done', to: 'contacts#done', as: 'done'
      end
      
     resources :addresses
     resources :searches
    get "search" => "searches#search"
    
    resources :categories, only:[:index, :edit, :create, :update]
    resources :real_estates, only:[:show, :new, :index, :edit, :create, :update] do
    resources :favorites , only: [:create , :destroy]
    end
    resources :negotiates, only:[:index, :edit, :create, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_real_estates, only:[:index, :update] do
      collection do
        get 'orders_real_estates/complete' => 'orders_real_estates#complete'
   end
   end
 end
  
  #genres
  namespace :public do
    resources :customers do
    resources :notifications, only: :index
    resources :relationships, only: [:create, :destroy] do
       get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
        get 'matchers' => 'relationships#matchers', as: 'matchers'
      end
      collection do
        get 'customers/leave' => 'customers#leave'
        patch 'customers/out' => 'customers#out'
      end
    end
   resources :searches
    get "search" => "searches#search"
    
    resources :categories, only:[:index, :edit, :create, :update]
    resources :real_estates do
    resources :favorites , only: [:create , :destroy]
    end
    resources :negotiates, only:[:index, :edit , :create, :update]
    resources :cart_real_estates, only:[:index, :create, :update, :destroy] do
    collection do
      delete 'public_cart_real_estates/destroy_all' => 'public_cart_real_estates#destroy_all'
    end
  end
      
      get 'orders/confirm'  => 'orders#confirm' 
      get 'orders/complete',to: 'orders#complete', as: "complete_order"
      get 'orders/new/:id',to: 'orders#new', as: "new_order"
      post 'orders/create/:id',to: 'orders#create', as: "create_order"
      resources :orders, only:[ :index, :show, :update] do
      end
      
    
    resources :order_real_estates, only:[:index, :update] do
      collection do
        get 'orders_real_estates/complete' => 'orders_real_estates#complete'
      end
    end
  resources :inquiry, only: [:new, :create]
  #negotiates
  resources :negotiates, only:[:index, :create, :update, :destroy] do
    collection do
      delete 'negotiates/destroy_all' => 'negotiates#destroy_all'
    end
  end
 end
end