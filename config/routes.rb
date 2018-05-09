Rails.application.routes.draw do
  unauthenticated :user do
    root to: 'sessions#new'
  end
  authenticated :user do
    root to: 'projects#index'
  end

  get  'mypage', to: 'users#edit'
  patch 'mypage', to: 'users#update'
  resources :users, only: [:update, :destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end

  get 'myproject', to: 'projects#myproject'
  resources :projects, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :columns, only: [:new, :create, :edit, :update, :destroy] do
      patch 'left',  to: 'columns#left'
      patch 'right', to: 'columns#right'
      resources :cards, only: [:new, :create, :edit, :update, :destroy] do
        patch 'left', to: 'cards#left'
        patch 'right', to: 'cards#right'
      end
    end
  end
end
