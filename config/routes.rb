Rails.application.routes.draw do
  resources :categories
  resources :blocks

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :manuals do
    resources :steps
  end

  resources :categories, :blocks, :users

  resources :textes, controller: 'blocks', type: 'Text'
  resources :videos, controller: 'blocks', type: 'Video'
  resources :images, controller: 'blocks', type: 'Image'

  root to: 'manuals#index'
end
