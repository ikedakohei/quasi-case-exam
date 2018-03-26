Rails.application.routes.draw do
  root 'projects#index'
  get  'login', to: 'sessions#new'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end
end
