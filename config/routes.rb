Rails.application.routes.draw do
  unauthenticated :user do
    root to: 'sessions#new'
  end
  authenticated :user do
    root to: 'projects#index'
  end

  get   'notification', to: 'notifications#index'
  get   'mypage', to: 'users#edit'
  patch 'mypage', to: 'users#update'
  resources :users, only: [:update, :destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end

  get 'myproject', to: 'projects#myproject'
  resources :projects, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      get 'invite'
    end
    resources :columns, only: [:new, :create, :edit, :update, :destroy] do
      patch 'move',  to: 'columns#move'
      resources :cards, only: [:new, :create, :edit, :update, :destroy] do
        patch 'move', to: 'cards#move'
      end
    end
    resources :logs, only: [:index]
  end

  resources :invitations, only: [:create, :update, :destroy] do
    member do
      patch 'refuse'
    end
  end
end
