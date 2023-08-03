Rails.application.routes.draw do


 scope module: :public do

    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "about"
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :index, :show ,:create] do
     collection { post 'confirm'}
     collection { get 'thanks'}
    end
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection { delete 'destroy_all'}
    end
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resource :customers, only: [:show, :edit, :update] do
     get 'confirm' => "customers#confirm"
     patch 'withdrawal' => "customers#withdrawal"
    end

 end

# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
    }

# 管理者用
# URL /admin/sign_in ...
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
 namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :customers, only: [:index, :show, :edit, :update] do
     resources :orders, only: [:index ,:show, :update]
     resources :order_details, only: [:update]
    end
    resources :genres, only: [:index, :show, :create, :edit, :update]

 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
