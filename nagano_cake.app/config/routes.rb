Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
    }
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
    get '/customers/my_page' => "customers#show"
    get '/customers/confirm' => "customers#confirm"
    patch '/customers/:id/withdrawal' => "customers#withdrawal", as: "withdrawal"
    get '/customers/edit/information' => "customers#edit"
    patch '/customers/information' => "customers#update"

 end

# 管理者用
# URL /admin/sign_in ...
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
 namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :show, :create, :edit, :update]
    get 'orders/show/:id' => "orders#show"

 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
