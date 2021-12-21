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
    resources :real_estates, only:[:show,:new, :index, :create, :update] do
    resources :favorites , only: [:create , :destroy]
    end
    resources :negotiates, only:[:index, :edit, :create, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_real_estates, only:[:index, :update] do
      collection do
        get 'orders_real_estates/complete' => 'orders_real_estates#complete'
      end
    end

  #negotiates
  resources :negotiates, only:[:index, :create, :update, :destroy] do
    collection do
      delete 'negotiates/destroy_all' => 'negotiates#destroy_all'
    end
  end
 end
end