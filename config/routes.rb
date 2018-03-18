Rails.application.routes.draw do
  root 'pages#index'
  get  'login', to: 'sessions#new'
end
