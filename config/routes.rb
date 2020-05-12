Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'
  root 'items#index'
  get '/about' => 'items#about' ,as: 'about'
  get '/inquiry' => 'items#inquiry' , as:'inquiry'

  #ユーザー側
  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }
  get '/users/:id' => 'users#show',as: 'user'
  resources :items do
    get '/order/new' => 'orders#new' ,as: 'new_order'
    post '/order' => 'order#create'
    post '/order/confirm' => 'orders#confirm',as: 'order_confirm'
  end
  resources :reviews

  #管理者側
  devise_for :admins, controllers: {
        sessions: 'admins/sessions'
      }

  namespace :admins do
    resources :genres
    resources :items
    resources :orders
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
