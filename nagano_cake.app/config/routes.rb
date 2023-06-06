Rails.application.routes.draw do
  root to: 'public/homes#top'
  get "public/homes/about" => "homes#about", as: "/about"
# 顧客用
# URL /customers/sign_in ...
 namespace :public do
   resources :registrations, except: [:passwords]
   resources :sessions, except: [:passwords]
 end

# 管理者用
# URL /admin/sign_in ...
 namespace :admin do
   resources :sessions, except: [:registrations, :passwords]
 end

 devise_for :public
 devise_for :admin

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
