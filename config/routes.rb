Rails.application.routes.draw do
  devise_for :users
  root 'projects#index'
  get  'login', to: 'sessions#new'
end
