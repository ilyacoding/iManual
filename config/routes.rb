Rails.application.routes.draw do
  resources :blocks

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :manuals, :steps, :blocks, :users

  resources :markdowns, controller: 'blocks', type: 'Markdown'
  resources :videos, controller: 'blocks', type: 'Video'
  resources :images, controller: 'blocks', type: 'Image'

  root to: 'manuals#index'
end
