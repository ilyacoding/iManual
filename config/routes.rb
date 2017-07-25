Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :manuals
  resources :steps

  scope '/api' do
    resources :manuals, :steps, :defaults => { :format => 'json' }
  end

  root to: 'manuals#index'
end
