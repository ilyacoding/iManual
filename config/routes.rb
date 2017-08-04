Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :manuals do
    resources :comments
    resources :steps
  end

  resources :categories, :blocks, :users, :tags

  resources :textes, controller: 'blocks', type: 'Text'
  resources :videos, controller: 'blocks', type: 'Video'
  resources :images, controller: 'blocks', type: 'Image'

  root to: 'manuals#index'
end
