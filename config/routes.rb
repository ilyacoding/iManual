Rails.application.routes.draw do
  root 'manuals#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :manuals do
    resources :pages
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'manuals#index'
end
