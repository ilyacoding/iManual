Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :manuals do
    resource :steps
  end

  root to: 'manuals#index'
end
