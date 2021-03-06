Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  
  # 請依照專案指定規格來設定路由
  resources :tweets, only: [:index, :create] do
    resources :replies, only: [:index, :create]
    member do
      post :like
      post :unlike
      
    end
  end
  
  resources :users, only: [:edit, :update] do  
    member do
      get :tweets
      # 看見某一使用者按過 like 的推播
      get :likes
      get :followers
      get :followings
    end
  end
  
  # 前台首頁：看見站內所有的推播，以及跟隨者最多的使用者
  root 'tweets#index'
  
  # 後台首頁：管理者登入網站後，能夠進入後台頁面
  namespace :admin do
    root "users#index"
    resources :tweets, only: [:index, :destroy]
    resources :users, only: [:index, :destroy]
  end

  # 追蹤／取消追蹤
  resources :followships, only: [:create, :destroy]

end
