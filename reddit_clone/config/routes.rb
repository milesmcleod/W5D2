Rails.application.routes.draw do


  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :posts, only: [:create, :update, :destroy, :show, :edit]
  resources :subs do
    resources :posts, except: [:index, :create, :update, :destroy, :edit] do
      resources :comments, only: [:new]
    end
  end

  root 'subs#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
