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

    get 'cart_items/index'
    get '/customers/my_page' => "customers#show"
    get '/customers/confirm' => "customers#confirm"
    patch '/customers/:id/withdrawal' => "customers#withdrawal", as: "withdrawal"
    get '/customers/edit/information' => "customers#edit"
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'

 end

# 管理者用
# URL /admin/sign_in ...
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
 namespace :admin do
    resources :items
    resources :cart_items, exit
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'orders/show'

 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
