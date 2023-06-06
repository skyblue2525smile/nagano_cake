Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
 namespace :public do
    devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
    }
    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "/about"
 end

# 管理者用
# URL /admin/sign_in ...
 namespace :admin do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
